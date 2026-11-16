-- pomodoro wrapper that is going to allow us to "focus" things ourselves
-- assumes pomodoro CLI is installed and available in the PATH
-- also assumes the cli is configured however it is desired so that defaults simply work

local M = {}

-- declaring the helpers in a forward way so that they can be used in the main functions without declaring them early
local notify, say, run

--- The only local state: watch keeps its timer and the last state here so it can notify on changes
---@type { timer: uv.uv_timer_t?, last: string? }
local watching = { timer = nil, last = nil }

--- Watch the status of the current pomodoro session and notify on changes
--- Leverages the watching variable above to keep private state and store the timer in memory
M.watch = function()
  if watching.timer then
    return
  end -- already watching
  watching.timer = vim.uv.new_timer()
  watching.timer:start(0, 5000, function() -- uv timers run off the main loop, like vim.system callbacks
    M.status({
      on_ok = function(text)
        local state = text == "" and "none" or text:find("❗") and "overdue" or "running"
        if state ~= watching.last then
          notify(text ~= "" and text or "Pomodoro ended")
          watching.last = state
        end
        if state == "none" then
          M.unwatch()
        end
      end,
    })
  end)
end

--- Start a new pomodoro session with the given description and tags
---@param desc string description of the pomodoro session
---@param tags? string[] tags for the pomodoro session
M.start = function(desc, tags)
  local args = { "start", desc }
  for _, tag in ipairs(tags or {}) do
    table.insert(args, "--tags")
    table.insert(args, tag)
  end

  run(args, say("Pomodoro started: " .. desc))
end

--- Cancel the current pomodoro session
M.cancel = function()
  run({ "cancel" }, say("Pomodoro canceled"))
end

--- Finish the current pomodoro session
M.finish = function()
  run({ "finish" }, say("Pomodoro finished"))
end

--- Get the status of the current pomodoro session
--- Notifies the status by default; pass on_ok to handle the text yourself
---@param opts? { on_ok?: fun(text: string), id?: integer|string }
M.status = function(opts)
  opts = opts or {}
  run({ "status" }, function(obj)
    local out = vim.trim(obj.stdout)
    if opts.on_ok then
      opts.on_ok(out)
    else
      notify(out ~= "" and out or "No pomodoro running", nil, opts.id)
    end
  end)
end

--- Stop watching the current pomodoro session
M.unwatch = function()
  if watching.timer then
    watching.timer:stop()
    watching.timer:close()
    watching.timer = nil
    watching.last = nil
  end
end

--- Run a command in a safe manner while also giving pluggable forms of feedback
--- Important for threading through the commands, including status, which has to be able to alter the output
---@param args string[] arguments to pass to the pomodoro command
---@param on_ok fun(obj: vim.SystemCompleted) callback on success
---@param on_fail? fun(obj: vim.SystemCompleted) callback on failure (default: notify with error)
function run(args, on_ok, on_fail)
  on_fail = on_fail
    or function(obj)
      notify("pomodoro " .. args[1] .. " failed: " .. obj.stderr, vim.log.levels.ERROR)
    end
  local cmd = vim.list_extend({ "pomodoro" }, args)
  vim.system(cmd, { text = true }, function(obj)
    vim.schedule(function()
      if obj.code == 0 then
        on_ok(obj)
      else
        on_fail(obj)
      end
    end)
  end)
end

--- Turn a fixed message into a success callback for run
---@param msg string the message to notify the user of
---@return fun()
function say(msg)
  return function()
    notify(msg)
  end
end

--- Notify the user of a message with a given log level
---@param msg string the message to notify the user of
---@param level? integer the log level (default: INFO)
---@param id? integer|string the notification ID, to replace an earlier notification
function notify(msg, level, id)
  vim.notify(msg, level or vim.log.levels.INFO, { title = "Pomodoro", id = id })
end

-- keymaps
vim.keymap.set("n", "<leader>pS", function()
  vim.ui.input({ prompt = "Pomodoro description: " }, function(input)
    if not input then
      return
    end
    if input == "" then
      input = "nvim"
    end
    M.start(input, { "nvim" })
  end)
end, { desc = "Start a new [p]omodoro [S]ession" })

vim.keymap.set("n", "<leader>ps", function()
  M.status({})
end, { desc = "Get current [p]omodoro [s]tatus" })

vim.keymap.set("n", "<leader>pw", function()
  M.watch()
end, { desc = "[w]atch current [p]omodoro" })

vim.keymap.set("n", "<leader>pc", function()
  M.cancel()
end, { desc = "[c]ancel current [p]omodoro" })

vim.keymap.set("n", "<leader>pf", function()
  M.finish()
end, { desc = "[f]inish current [p]omodoro" })

-- rich comment: meant to be evaluated in a REPL, not in the file itself
if false then
  local p = dofile(vim.fn.expand("%:p"))
  p.start("repl test", { "y" })
  p.status()
  p.watch()
  p.cancel()
  p.finish()
end

return M
