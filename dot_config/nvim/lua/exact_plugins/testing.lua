-- Running tests in the editor. neotest is the runner and UI; each language needs an adapter.
-- Rust's adapter comes from rustaceanvim, which finds tests through rust-analyzer. rustaceanvim
-- also owns the rust-analyzer client, so rust_analyzer stays out of vim.lsp.enable in options.lua.
vim.pack.add({
  { src = "https://github.com/mrcjkb/rustaceanvim", version = vim.version.range("^9") },
  "https://github.com/nvim-neotest/nvim-nio",
  "https://github.com/nvim-neotest/neotest",
})

require("neotest").setup({
  adapters = {
    require("rustaceanvim.neotest"),
  },
})

local neotest = require("neotest")
vim.keymap.set("n", "<leader>tn", function() neotest.run.run() end, { desc = "[t]est the [n]earest case" })
vim.keymap.set("n", "<leader>tf", function() neotest.run.run(vim.fn.expand("%")) end, { desc = "[t]est the current [f]ile" })
-- No suite key: rustaceanvim's adapter can't run a directory, so neotest would start one cargo
-- per test (947 in clearhead-core). Run the suite with cargo in a terminal.
vim.keymap.set("n", "<leader>ut", function() neotest.summary.toggle() end, { desc = "[u]i: [t]est summary" })
