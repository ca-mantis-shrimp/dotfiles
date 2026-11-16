-- focus the action under the cursor: a pomodoro named after it, tagged so an agent can key off it

--- Namespaced tags so values from different fields never collide (a context and a charter can share a name)
---@param action table canonical action JSON from `clearhead read actions -f json`
---@param charter string
---@return string[]
local function tags_for(action, charter)
  local tags = { "id:" .. action.id, "charter:" .. charter }
  if action.alias then
    table.insert(tags, "alias:" .. action.alias)
  end
  for _, context in ipairs(action.contexts or {}) do
    table.insert(tags, "+" .. context)
  end
  return tags
end

vim.keymap.set("n", "<localleader>F", function()
  local id = require("clearhead").action_id_under_cursor()
  if not id then
    return vim.notify("No action under cursor", vim.log.levels.WARN)
  end
  local file = vim.api.nvim_buf_get_name(0)
  local cmd = { "clearhead", "read", "actions", "--file", file, "-f", "json" }
  vim.system(
    cmd,
    { text = true },
    vim.schedule_wrap(function(obj)
      if obj.code ~= 0 then
        return vim.notify("clearhead read failed: " .. obj.stderr, vim.log.levels.ERROR)
      end
      local ok, data = pcall(vim.json.decode, obj.stdout)
      local action = ok and vim.iter(data.actions):find(function(a)
        return a.id == id
      end)
      if not action then
        return vim.notify("Action " .. id .. " not found in " .. file, vim.log.levels.ERROR)
      end
      -- only root actions carry a charter; the file name is the charter for the rest
      local charter = action.charter or vim.fn.fnamemodify(file, ":t:r")
      require("plugins.pomodoro").start(action.name, tags_for(action, charter))
    end)
  )
end, { buffer = true, desc = "[f]ocus [a]ction under cursor" })
