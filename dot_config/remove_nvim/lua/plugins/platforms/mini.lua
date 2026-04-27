vim.pack.add({ "https://github.com/echasnovski/mini.nvim" })

require("mini.ai").setup({ n_lines = 500 })
require("mini.surround").setup()
require("mini.statusline").setup()
require("mini.tabline").setup()
