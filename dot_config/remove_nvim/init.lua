require("config.options")
require("config.utils")

-- local plugins managed outside vim.pack
vim.opt.rtp:prepend(vim.fn.expand("~/Products/tree-sitter-actions"))

-- Probably the primary thing that needs to be loaded FIRST as if there are deps they likely live here
require("plugins.libs")

-- Large platform plugins mean that these are the more impactful elements of the config and should be considered on their own
require("plugins.platforms.mini")
require("plugins.platforms.snacks")
require("plugins.platforms.blink")
require("plugins.platforms.conform")
require("plugins.platforms.treesitter")

-- Next we go into the vertical slice use-case plugins, these are more focused on a specific use-case and may be a collection of different plugins based on the use-case
require("plugins.colorschemes")
require("plugins.git")
require("plugins.navigation")
require("plugins.LLM")
require("plugins.prose")
require("plugins.clearhead")

-- Finally, we set keymaps and autocmds last because they may depend on plugins being loaded and configured first, and we want to ensure that all plugins are available before we set up keymaps and autocmds that may rely on them.
require("config.keymaps")
require("config.autocmds")

-- trying out the new ui2 of vim
require("vim._core.ui2").enable({})
