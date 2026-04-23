-- clearhead is a local plugin with pre-compiled Lua, loaded via rtp
vim.opt.rtp:prepend(vim.fn.expand("~/Products/platform/clearhead.nvim"))

local clearhead = require("clearhead")
clearhead.setup({})

vim.keymap.set("n", "<leader>ti", "<cmd>ClearheadInbox<CR>", { desc = "Open Clearhead inbox" })
vim.keymap.set("n", "<leader>to", "<cmd>ClearheadWorkspace<CR>", { desc = "Open .actions in current dir" })

vim.api.nvim_create_autocmd("FileType", {
  pattern = "actions",
  callback = function()
    local function map(key, fn, desc)
      vim.keymap.set("n", key, fn, { buffer = true, desc = desc })
    end
    map("<leader>tt", function() clearhead.cycle_state(0, vim.fn.line(".") - 1) end, "Cycle task state")
    map("<leader>tx", function() clearhead.set_state(0, vim.fn.line(".") - 1, "x") end, "Mark as completed")
    map("<leader>tX", function() clearhead.set_state_tree(0, vim.fn.line(".") - 1, "x") end, "Mark as completed with children")
    map("<leader>t-", function() clearhead.set_state(0, vim.fn.line(".") - 1, "-") end, "Mark as in-progress")
    map("<leader>t=", function() clearhead.set_state(0, vim.fn.line(".") - 1, "=") end, "Mark as blocked")
    map("<leader>t_", function() clearhead.set_state(0, vim.fn.line(".") - 1, "_") end, "Mark as cancelled")
    map("<leader>t<space>", function() clearhead.set_state(0, vim.fn.line(".") - 1, " ") end, "Mark as not started")
  end,
})
