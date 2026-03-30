-- clearhead is a local plugin with pre-compiled Lua, loaded via rtp
vim.opt.rtp:prepend(vim.fn.expand("~/Products/platform/clearhead.nvim"))

local clearhead = require("clearhead")
clearhead.setup({})

vim.keymap.set("n", "<leader>ti", "<cmd>ClearheadInbox<CR>", { desc = "Open Clearhead inbox" })
vim.keymap.set("n", "<leader>to", "<cmd>ClearheadOpenDir<CR>", { desc = "Open .actions in current dir" })

vim.api.nvim_create_autocmd("FileType", {
  pattern = "actions",
  callback = function()
    vim.keymap.set("n", "<leader>tt", clearhead["cycle-state"], { buffer = true, desc = "Cycle task state" })
    vim.keymap.set("n", "<leader>tx", clearhead["set-state"]("x"), { buffer = true, desc = "Mark as completed" })
    vim.keymap.set("n", "<leader>t-", clearhead["set-state"]("-"), { buffer = true, desc = "Mark as in-progress" })
    vim.keymap.set("n", "<leader>t=", clearhead["set-state"]("="), { buffer = true, desc = "Mark as blocked" })
    vim.keymap.set("n", "<leader>t_", clearhead["set-state"]("_"), { buffer = true, desc = "Mark as cancelled" })
    vim.keymap.set(
      "n",
      "<leader>t<space>",
      clearhead["set-state"](" "),
      { buffer = true, desc = "Mark as not started" }
    )
  end,
})
