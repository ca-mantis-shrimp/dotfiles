-- Agent sessions in a side split, redrawn the moment one changes. A reader of agent-status's records
-- (~/Products/agent-status, README "The record"): those waiting on you first, dead sessions left out.
-- It watches the records directory only while the split is open; a slow tick keeps the ages honest.
-- It never notifies: engaging with a session is a decision made by looking (agent-status DECISIONS.md, 4).
local M = {}

local dir = (
  vim.env.AGENT_STATUS_DIR or ((vim.env.XDG_RUNTIME_DIR or ("/run/user/" .. vim.uv.getuid())) .. "/agent-status")
) .. "/sessions"
local ns = vim.api.nvim_create_namespace("agent_sessions")
local look = {
  ["input-required"] = { rank = 0, mark = "!", hl = "DiagnosticError" },
  completed = { rank = 1, mark = "✓", hl = "DiagnosticWarn" },
  working = { rank = 2, mark = "…", hl = "Comment" },
}
local unknown = { rank = 3, mark = "?", hl = "Comment" }
-- Split state and the explicitly chosen session (local to this nvim).
local live = {}
local focused

local function read(path)
  local ok, rec = pcall(function()
    return vim.json.decode(table.concat(vim.fn.readfile(path), "\n"))
  end)
  if
    ok
    and type(rec) == "table"
    and type(rec.state) == "string"
    and type(rec.since) == "string"
    and type(rec.harness) == "string"
    and type(rec.session) == "string"
  then
    return rec
  end
end

local function records()
  local out = {}
  if not vim.uv.fs_stat(dir) then
    return out
  end
  for name in vim.fs.dir(dir) do
    local rec = name:match("%.json$") and read(dir .. "/" .. name)
    if rec and (not rec.pid or vim.uv.kill(rec.pid, 0) == 0) then
      table.insert(out, rec)
    end
  end
  table.sort(out, function(a, b)
    local ra, rb = (look[a.state] or unknown).rank, (look[b.state] or unknown).rank
    if ra ~= rb then
      return ra < rb
    end
    return a.since < b.since
  end)
  return out
end

--- How long ago an RFC 3339 UTC time was: 5s, 3m, 2h, 1d
local function age(since)
  local y, mo, d, h, mi, s = since:match("(%d+)-(%d+)-(%d+)T(%d+):(%d+):(%d+)")
  if not y then
    return "?"
  end
  local now = os.time()
  local offset = os.difftime(now, os.time(os.date("!*t", now)))
  local secs = math.max(0, now - (os.time({ year = y, month = mo, day = d, hour = h, min = mi, sec = s }) + offset))
  for _, unit in ipairs({ { 86400, "d" }, { 3600, "h" }, { 60, "m" } }) do
    if secs >= unit[1] then
      return math.floor(secs / unit[1]) .. unit[2]
    end
  end
  return secs .. "s"
end

local function label(rec)
  return rec.name or vim.fs.basename(rec.project or "?")
end

local function render()
  local buf = live.buf
  if not (buf and vim.api.nvim_buf_is_valid(buf)) then
    return
  end
  local lines, groups, rows = {}, {}, {}
  local rec
  local function add(line, group)
    table.insert(lines, line)
    table.insert(groups, group)
    rows[#lines] = rec
  end
  for _, r in ipairs(records()) do
    rec = r
    local l = look[rec.state] or unknown
    add(string.format("%s %3s  %s", l.mark, age(rec.since), label(rec)), l.hl)
    if rec.reason then
      add("       " .. rec.reason, "Comment")
    end
  end
  rec = nil
  live.rows = rows
  if #lines == 0 then
    add("no agent sessions", "Comment")
  end
  vim.bo[buf].modifiable = true
  vim.api.nvim_buf_set_lines(buf, 0, -1, false, lines)
  vim.bo[buf].modifiable = false
  vim.api.nvim_buf_clear_namespace(buf, ns, 0, -1)
  for i, group in ipairs(groups) do
    vim.api.nvim_buf_set_extmark(buf, ns, i - 1, 0, { line_hl_group = group })
  end
end

--- The sidekick view running a process: a terminal whose job is the process or one of its ancestors, or a
--- tool that attaches to the shpool session the process runs in (facilitator, focus). Nil when it runs outside nvim.
---@param pid integer
---@return { state?: sidekick.cli.State, tool?: string }?
local function sidekick_for(pid)
  local jobs = {}
  for _, state in ipairs(require("sidekick.cli.state").get({ terminal = true })) do
    for _, job in ipairs(state.session.pids or {}) do
      jobs[job] = state
    end
  end
  local p = pid
  while p and p > 1 do
    if jobs[p] then
      return { state = jobs[p] }
    end
    p = (vim.api.nvim_get_proc(p) or {}).ppid
  end
  local environ = io.open("/proc/" .. pid .. "/environ", "rb")
  local shpool = environ and ("\0" .. environ:read("*a")):match("%zSHPOOL_SESSION_NAME=([^%z]+)")
  if environ then
    environ:close()
  end
  for name, tool in pairs(shpool and require("sidekick.config").tools() or {}) do
    if tool.cmd[1] == "shpool" and vim.tbl_contains(tool.cmd, shpool) then
      return { tool = name }
    end
  end
end

local function session_key(rec)
  return rec.harness .. ":" .. rec.session
end

local function find_session(key)
  for _, rec in ipairs(records()) do
    if session_key(rec) == key then
      return rec
    end
  end
end

local function sidekick_opts(rec)
  local where = rec and rec.pid and sidekick_for(rec.pid)
  if where then
    return { focus = true, filter = { name = where.tool, session = where.state and where.state.session.id } }
  end
end

local function select_session(key)
  local rec = find_session(key)
  if not rec then
    return vim.notify("That agent session ended", vim.log.levels.WARN)
  end
  local opts = sidekick_opts(rec)
  if not opts then
    return vim.notify(label(rec) .. " runs outside this nvim; open it where it started", vim.log.levels.WARN)
  end

  local State = require("sidekick.cli.state")
  for _, state in ipairs(State.get({ attached = true, terminal = true })) do
    if state.terminal:is_open() and not State.is(state, opts.filter) then
      state.terminal:hide()
    end
  end
  focused = key
  require("sidekick.cli").show(opts)
end

function M.open()
  local rec = (live.rows or {})[vim.fn.line(".")]
  if rec then
    select_session(session_key(rec))
  end
end

function M.pick()
  local items = {}
  for _, rec in ipairs(records()) do
    local id = session_key(rec)
    local current = id == focused and "[current] " or ""
    local text =
      string.format("%s%s  ·  %s  ·  %s  ·  %s", current, label(rec), rec.state, rec.harness, rec.project or "")
    items[#items + 1] = { id = id, text = text }
  end
  if #items == 0 then
    return vim.notify("No live agent sessions")
  end
  return Snacks.picker.pick({
    title = "Focus agent session",
    items = items,
    layout = "select",
    format = "text",
    sort = { fields = { "score:desc", "idx" } },
    confirm = function(picker, item)
      picker:close()
      if item then
        select_session(item.id)
      end
    end,
  })
end

--- Focus the next (1) or previous (-1) session this nvim can show, in the pane's order, wrapping around
---@param dir 1|-1
function M.step(dir)
  local reachable = vim.tbl_filter(sidekick_opts, records())
  if #reachable == 0 then
    return vim.notify("No agent sessions open in this nvim")
  end
  local at = dir == 1 and 0 or #reachable + 1
  for i, rec in ipairs(reachable) do
    if session_key(rec) == focused then
      at = i
    end
  end
  local i = (at - 1 + dir) % #reachable + 1
  select_session(session_key(reachable[i]))
  vim.notify(string.format("%d/%d  %s", i, #reachable, label(reachable[i])))
end

function M.toggle_agent()
  local cli = require("sidekick.cli")
  if vim.w.sidekick_session_id then
    return cli.hide({ filter = { session = vim.w.sidekick_session_id } })
  end
  if not focused then
    return cli.toggle()
  end
  local opts = sidekick_opts(find_session(focused))
  if not opts then
    focused = nil
    return vim.notify("Focused agent is no longer reachable; pick another with <leader>ag", vim.log.levels.WARN)
  end
  return cli.toggle(opts)
end

local function stop()
  for _, handle in ipairs({ live.watcher, live.soon, live.tick }) do
    if not handle:is_closing() then
      handle:close()
    end
  end
  live = {}
end

-- A hook writes a temporary file, then renames it: wait 100ms for the burst to settle, then redraw once.
local function start()
  vim.fn.mkdir(dir, "p")
  live.soon, live.tick, live.watcher = vim.uv.new_timer(), vim.uv.new_timer(), vim.uv.new_fs_event()
  live.watcher:start(dir, {}, function()
    live.soon:stop()
    live.soon:start(100, 0, vim.schedule_wrap(render))
  end)
  live.tick:start(30000, 30000, vim.schedule_wrap(render))
end

--- Open the split on the right, or close it if it is open; focus stays where it was
function M.toggle()
  local win = live.buf and vim.fn.bufwinid(live.buf) or -1
  if win ~= -1 then
    return vim.api.nvim_win_close(win, true)
  end
  vim.cmd("botright 40vnew")
  live.buf = vim.api.nvim_get_current_buf()
  vim.bo.buftype, vim.bo.bufhidden, vim.bo.swapfile, vim.bo.filetype = "nofile", "wipe", false, "agentsessions"
  vim.wo.wrap, vim.wo.number, vim.wo.relativenumber, vim.wo.winfixwidth = false, false, false, true
  vim.api.nvim_create_autocmd("BufWipeout", { buffer = live.buf, once = true, callback = stop })
  vim.keymap.set("n", "<CR>", M.open, { buffer = live.buf, desc = "Open this session in sidekick" })
  start()
  render()
  vim.cmd("wincmd p")
end

vim.keymap.set("n", "<leader>al", M.toggle, { desc = "[a]gent sessions [l]ist, live" })
vim.keymap.set("n", "<leader>ag", M.pick, { desc = "[a]gent sessions: [g]o to and focus" })
vim.keymap.set({ "n", "t", "i", "x" }, "<c-.>", M.toggle_agent, { desc = "Toggle focused agent" })
vim.keymap.set({ "n", "t", "i", "x" }, "<m-.>", function()
  M.step(1)
end, { desc = "Next agent session, in the pane's order" })
vim.keymap.set({ "n", "t", "i", "x" }, "<m-,>", function()
  M.step(-1)
end, { desc = "Previous agent session, in the pane's order" })

return M
