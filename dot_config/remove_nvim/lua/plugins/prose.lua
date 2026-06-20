vim.pack.add({ "https://github.com/MeanderingProgrammer/render-markdown.nvim" })
vim.pack.add({ "https://github.com/obsidian-nvim/obsidian.nvim" })

require("render-markdown").setup({ file_types = { "markdown", "Avante" } })

require("obsidian").setup({
  workspaces = { { name = "knowledge base", path = "~/Documents/knowledge_base" } },
  daily_notes = {
    folder = "daily",
    date_format = "YYYY/MM/DD",
  },
  legacy_commands = false,
})

local function open_daily(note)
  if not note:exists() then note:write() end
  note:open()
end

local ok, wk = pcall(require, "which-key")
if ok then
  wk.add({
    { "<leader>j", group = "[j]ournal" },
    { "<leader>jt", function() open_daily(require("obsidian.daily").today()) end, desc = "[j]ournal [t]oday" },
    { "<leader>jy", function() open_daily(require("obsidian.daily").yesterday()) end, desc = "[j]ournal [y]esterday" },
    { "<leader>jT", function() open_daily(require("obsidian.daily").tomorrow()) end, desc = "[j]ournal [T]omorrow" },
  })
end
