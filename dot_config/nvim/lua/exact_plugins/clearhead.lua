-- clearhead is a local plugin with pre-compiled Lua, loaded via rtp
vim.opt.rtp:prepend(vim.fn.expand("~/Products/platform/clearhead.nvim"))

local clearhead = require("clearhead")
clearhead.setup({ nvim_archive_on_save = true })

vim.keymap.set("n", "<leader>ti", "<cmd>ClearheadInbox<CR>", { desc = "Open Clearhead inbox" })
vim.keymap.set("n", "<leader>to", "<cmd>ClearheadWorkspace<CR>", { desc = "Open .actions in current dir" })
