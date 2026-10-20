vim.pack.add({
  "https://github.com/neovim/nvim-lspconfig",
  "https://github.com/nvim-lua/plenary.nvim",
  "https://github.com/nvim-treesitter/nvim-treesitter-textobjects",
  "https://github.com/folke/which-key.nvim",
  "https://github.com/nvim-treesitter/nvim-treesitter",
})

-- Our .actions grammar builds from the platform checkout; its queries come from the
-- runtimepath entry in init.lua, so edits to them apply without reinstalling.
vim.api.nvim_create_autocmd("User", {
  pattern = "TSUpdate",
  callback = function()
    require("nvim-treesitter.parsers").actions = {
      install_info = { path = vim.fn.expand("~/Products/platform/tree-sitter-actions") },
    }
  end,
})
-- Parsers for the languages we configure, plus nvim's own. install() skips what is
-- present, so this is cheap at startup; it needs the tree-sitter CLI (chezmoi, linux/amd64
-- only) and cc. Without the CLI (the phone) nvim keeps its bundled parsers.
if vim.fn.executable("tree-sitter") == 1 then
  require("nvim-treesitter").install({
    "actions", "bash", "clojure", "fish", "javascript", "json", "lua", "markdown", "markdown_inline",
    "python", "query", "rust", "toml", "tsx", "typescript", "vim", "vimdoc",
  })
end
-- Parsers must match the plugin's version, so update them whenever vim.pack updates it.
vim.api.nvim_create_autocmd("PackChanged", {
  callback = function(event)
    if event.data.spec.name == "nvim-treesitter" and event.data.kind == "update" then
      require("nvim-treesitter").update()
    end
  end,
})

require("which-key").setup()
vim.keymap.set("n", "<leader>?", function()
  require("which-key").show({ global = false })
end, { desc = "Show Buffer Keymaps" })
