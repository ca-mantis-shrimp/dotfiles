-- Landings waiting for my verdict: browse each review bundle in a picker (the
-- strategic view), open one as a quickfix list to read the code (the tactical
-- view), then agree or disagree with the bundle or with one finding, by key.
-- Talks only to the agent CLI from agent-sandbox, never to its run records.
local M = { current = nil }

local function run(cmd)
  local out = vim.fn.systemlist(cmd)
  if vim.v.shell_error ~= 0 then
    return nil
  end
  return out
end

local function pending()
  local items = {}
  for _, line in ipairs(run({ "agent", "verdict", "--pending" }) or {}) do
    local id, repo, label = unpack(vim.split(line, "\t"))
    local bundle = run({ "agent", "show", id }) or { "(agent show " .. id .. " failed)" }
    table.insert(items, {
      id = id,
      text = id .. "  " .. repo .. "  " .. (label or ""),
      preview = { text = table.concat(bundle, "\n") },
    })
  end
  return items
end

function M.open(id)
  local bundle = run({ "agent", "show", id })
  if not bundle then
    return vim.notify("agent show " .. id .. " failed", vim.log.levels.ERROR)
  end
  vim.fn.setqflist({}, " ", { title = "review " .. id, lines = bundle })
  M.current = id
  vim.cmd("copen")
end

function M.pick()
  local items = pending()
  if #items == 0 then
    return vim.notify("No landings waiting for a verdict")
  end
  Snacks.picker.pick({
    title = "Landings waiting for a verdict",
    items = items,
    format = "text",
    preview = "preview",
    confirm = function(picker, item)
      picker:close()
      if item then
        M.open(item.id)
      end
    end,
  })
end

-- flags: { "--agree" }, { "--on", "2#1", "--disagree" }, ...; an empty note is left out.
local function record(flags, note)
  if not M.current then
    return vim.notify("No landing open: pick one with <leader>vv", vim.log.levels.WARN)
  end
  local cmd = vim.list_extend({ "agent", "verdict", M.current, "--by", "human" }, flags)
  if note and note ~= "" then
    vim.list_extend(cmd, { "--note", note })
  end
  vim.notify(vim.trim(vim.fn.system(cmd)))
end

-- Ask for a note, then record; cancelling (<Esc>) records nothing.
local function ask(prompt, flags)
  vim.ui.input({ prompt = prompt }, function(note)
    if note then
      record(flags, note)
    end
  end)
end

function M.agree()
  ask("Agree. Comment (optional): ", { "--agree" })
end

function M.disagree()
  ask("Why do you disagree? ", { "--disagree" })
end

-- The finding id (2#1) on the quickfix entry under the cursor in the quickfix
-- window, or on the current entry anywhere else (after :cnext into the code).
local function finding()
  local idx = vim.bo.buftype == "quickfix" and vim.fn.line(".") or vim.fn.getqflist({ idx = 0 }).idx
  local item = vim.fn.getqflist()[idx]
  return item and item.text:match("(%d+#%d+)")
end

local function on_finding(prompt, flag)
  local id = finding()
  if not id then
    return vim.notify("No finding id on this quickfix entry", vim.log.levels.WARN)
  end
  local flags = { "--on", id }
  if flag then
    table.insert(flags, flag)
  end
  ask(id .. " " .. prompt, flags)
end

function M.finding_agree()
  on_finding("agree. Comment (optional): ", "--agree")
end

function M.finding_disagree()
  on_finding("why do you disagree? ", "--disagree")
end

function M.finding_comment()
  on_finding("comment: ")
end

vim.keymap.set("n", "<leader>vv", M.pick, { desc = "Landings waiting for a [v]erdict" })
vim.keymap.set("n", "<leader>va", M.agree, { desc = "[a]gree with the open landing's review" })
vim.keymap.set("n", "<leader>vd", M.disagree, { desc = "[d]isagree with the open landing's review" })
vim.keymap.set("n", "<leader>vfa", M.finding_agree, { desc = "[a]gree with this finding" })
vim.keymap.set("n", "<leader>vfd", M.finding_disagree, { desc = "[d]isagree with this finding" })
vim.keymap.set("n", "<leader>vfc", M.finding_comment, { desc = "[c]omment on this finding" })

return M
