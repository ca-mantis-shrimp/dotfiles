vim.pack.add({ "https://github.com/nvim-treesitter/nvim-treesitter" })

-- nvim-treesitter fires User TSUpdate before reading its parser list.
-- Injecting here is the correct hook for custom parsers in the new API.
vim.api.nvim_create_autocmd("User", {
  pattern = "TSUpdate",
  callback = function()
    require("nvim-treesitter.parsers").actions = {
      install_info = {
        path = vim.fn.expand("~/Products/platform/tree-sitter-actions"),
        queries = "queries/actions",
      },
    }
  end,
})

vim.api.nvim_create_autocmd("PackChanged", {
  callback = function(ev)
    if ev.data.spec.name ~= "nvim-treesitter" then return end
    if not ev.data.active then
      vim.cmd.packadd("nvim-treesitter")
    end
    vim.cmd("TSUpdate")
  end,
})
