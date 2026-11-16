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

vim.keymap.set("n", "<leader>ti", "<Plug>(clearhead-open-inbox)")
vim.keymap.set("n", "<leader>tw", "<Plug>(clearhead-open-workspace)")
vim.keymap.set("n", "<leader>to", "<Plug>(clearhead-open-project)")

-- quickfix isn't clearhead's filetype, so its living-loop keys are opt-in
vim.api.nvim_create_autocmd("FileType", {
  pattern = "qf",
  callback = function(ev)
    local function map(lhs, name)
      vim.keymap.set("n", lhs, "<Plug>(clearhead-" .. name .. ")", { buffer = ev.buf })
    end
    map("<localleader>x", "entry-complete")
    map("<localleader>_", "entry-cancel")
    map("<localleader>r", "refresh-view")
  end,
})
