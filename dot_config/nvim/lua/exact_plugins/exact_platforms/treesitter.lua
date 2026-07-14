vim.pack.add({ "https://github.com/arborist-ts/arborist.nvim" })

-- The actions parser (.so) lives in ~/.local/share/nvim/site/parser/ and its
-- queries are on the rtp via init.lua (~/Products/platform/tree-sitter-actions).
-- Tell arborist to leave it alone.
require("arborist").setup({
  ignore = { "actions" },
})
