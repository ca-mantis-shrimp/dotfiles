-- snacks plugin collecton
vim.pack.add({ "https://github.com/folke/snacks.nvim" })

require("snacks").setup({
  bigfile = { enabled = true },
  dashboard = {
    sections = {
      { section = "header" },
      { icon = "", title = "Keymaps", section = "keys" },
      { icon = "", title = "Recent Files", section = "recent_files" },
      { icon = "", title = "Projects", section = "projects" },
    },
  },
  explorer = { enabled = true },
  indent = { enabled = true },
  input = { enabled = true },
  picker = { enabled = true },
  notifier = { enabled = true },
  quickfile = { enabled = true },
  scope = { enabled = true },
  scroll = { enabled = true },
  statuscolumn = { enabled = true },
  words = { enabled = true },
  zen = {},
})

vim.keymap.set("n", "<leader><space>", function()
  Snacks.picker.smart()
end, { desc = "Smart Find Files" })
vim.keymap.set("n", "<leader>,", function()
  Snacks.picker.buffers()
end, { desc = "Search Buffers" })
vim.keymap.set("n", "<leader>/", function()
  Snacks.picker.grep()
end, { desc = "Grep Files" })
vim.keymap.set("n", "<leader>:", function()
  Snacks.picker.command_history()
end, { desc = "Search Command History" })
vim.keymap.set("n", "<leader>N", function()
  Snacks.picker.notifications()
end, { desc = "Search Notifications" })
vim.keymap.set("n", "<leader>e", function()
  Snacks.explorer()
end, { desc = "Open File Explorer" })
vim.keymap.set("n", '<leader>"', function()
  Snacks.picker.registers()
end, { desc = "Search Registers" })
vim.keymap.set("n", "<leader>sh", function()
  Snacks.picker.help()
end, { desc = "Search Help Docs" })
vim.keymap.set("n", "<leader>sm", function()
  Snacks.picker.marks()
end, { desc = "Search Marks" })
vim.keymap.set("n", "<leader>sM", function()
  Snacks.picker.man()
end, { desc = "Search Man Pages" })
vim.keymap.set("n", "<leader>sk", function()
  Snacks.picker.keymaps()
end, { desc = "Search Keymaps" })
vim.keymap.set("n", "<leader>sp", function()
  Snacks.picker.projects()
end, { desc = "Search Projects" })
vim.keymap.set("n", "<leader>sc", function()
  Snacks.picker.commands()
end, { desc = "Search Commands" })
vim.keymap.set("n", "<leader>si", function()
  Snacks.picker.icons()
end, { desc = "Search Icons" })
vim.keymap.set("n", "<leader>sj", function()
  Snacks.picker.jumps()
end, { desc = "Search Jumps" })
vim.keymap.set("n", "<leader>sd", function()
  Snacks.picker.diagnostics()
end, { desc = "Search Diagnostics" })
vim.keymap.set("n", "<c-/>", function()
  Snacks.terminal()
end, { desc = "Open Horizontal Terminal Window" })
vim.keymap.set("n", "<leader>uz", function()
  Snacks.zen()
end, { desc = "Zen Mode" })
