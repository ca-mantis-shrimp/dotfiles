-- Landings waiting for my verdict: browse each review bundle in a picker (the
-- strategic view), open one as a quickfix list to read the code (the tactical
-- view), then agree or disagree with a key. Talks only to the agent CLI from
-- agent-sandbox, never to its run records.
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

local function record(flag, note)
  if not M.current then
    return vim.notify("No landing open: pick one with <leader>vv", vim.log.levels.WARN)
  end
  local cmd = { "agent", "verdict", M.current, flag }
  if note and note ~= "" then
    vim.list_extend(cmd, { "--note", note })
  end
  vim.notify(vim.trim(vim.fn.system(cmd)))
end

function M.agree()
  record("--agree")
end

function M.disagree()
  vim.ui.input({ prompt = "Why do you disagree? " }, function(note)
    if note then
      record("--disagree", note)
    end
  end)
end

vim.keymap.set("n", "<leader>vv", M.pick, { desc = "Landings waiting for a [v]erdict" })
vim.keymap.set("n", "<leader>va", M.agree, { desc = "[a]gree with the open landing's review" })
vim.keymap.set("n", "<leader>vd", M.disagree, { desc = "[d]isagree with the open landing's review" })

return M
