-- clearhead is a local plugin with pre-compiled Lua, loaded via rtp
vim.opt.rtp:prepend(vim.fn.expand("~/Products/platform/clearhead.nvim"))

-- the actions parser and its queries install together from a release tag;
-- bump `revision` and run :TSUpdate to upgrade
vim.api.nvim_create_autocmd("User", {
  pattern = "TSUpdate",
  callback = function()
    require("nvim-treesitter.parsers").actions = {
      install_info = {
        url = "https://github.com/ClearHeadToDo-Devs/tree-sitter-actions",
        revision = "v0.10.0",
        queries = "queries/actions",
      },
    }
  end,
})

local clearhead = require("clearhead")
clearhead.setup({ nvim_archive_on_save = true })

vim.keymap.set("n", "<leader>ti", "<cmd>ClearheadInbox<CR>", { desc = "Open Clearhead inbox" })
vim.keymap.set("n", "<leader>to", "<cmd>ClearheadWorkspace<CR>", { desc = "Open .actions in current dir" })
