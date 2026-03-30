require("config.options")
require("config.utils")

-- local plugins managed outside vim.pack
vim.opt.rtp:prepend(vim.fn.expand("~/Products/tree-sitter-actions"))

-- wrap plugin loads so first-run installation is graceful
-- on first run vim.pack installs plugins but they aren't available until restart
local function load(mod)
  local ok, err = pcall(require, mod)
  if not ok and not err:find("not found", 1, true) then
    vim.notify(err, vim.log.levels.ERROR)
  end
end

load("plugins.platforms.mini")
load("plugins.platforms.snacks")
load("plugins.platforms.treesitter")
load("plugins.platforms.blink")
load("plugins.platforms.conform")
load("plugins.libs")
load("plugins.colorschemes")
load("plugins.git")
load("plugins.navigation")
load("plugins.LLM")
load("plugins.prose")
load("plugins.clearhead")

require("config.keymaps")
require("config.autocmds")
