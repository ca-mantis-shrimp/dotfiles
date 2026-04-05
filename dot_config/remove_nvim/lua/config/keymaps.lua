local wk = require("which-key")

--- Opens todays journal entry, creating it if it doesn't exist. Journal entries are stored in ~/journal/years/YYYY/MM/DD.md
--- Doing this to replace the neorg journal module with a single function
local function open_journal_today()
  local current_date = os.date("*t")
  local path = vim.fn.expand(
    string.format("~/journal/years/%04d/%02d/%02d.md", current_date.year, current_date.month, current_date.day)
  )
  vim.fn.mkdir(vim.fn.fnamemodify(path, ":h"), "p")
  if vim.fn.filereadable(path) == 0 then
    vim.fn.writefile(
      { string.format("# %04d-%02d-%02d", current_date.year, current_date.month, current_date.day), "" },
      path
    )
  end
  vim.cmd.edit(path)
end

-- By keeping the core keymaps in a which-key invocation we ensure the UI is built properly on startup
wk.add({
  { "<leader>u", group = "[u]i" },
  { "<leader>s", group = "[s]earch" },
  { "<leader>t", group = "[t]est" },
  { "<leader>i", group = "[I]ntentions" },
  { "<leader>m", "<cmd>make<CR>", desc = "Run [m]ake" },
  { "<Esc>", "<cmd>nohlsearch<CR>", desc = "Remove Search Highlighting on Escape" },
  { "<Esc><Esc>", "<C-\\><C-n>", mode = "t", desc = "[Esc]ape terminal mode" },
  {
    "[d",
    function()
      vim.diagnostic.jump({ count = -1 })
    end,
    desc = "Go to previous [D]iagnostic message",
  },
  {
    "]d",
    function()
      vim.diagnostic.jump({ count = 1 })
    end,
    desc = "Go to next [D]iagnostic message",
  },
  { "<leader>q", vim.diagnostic.setloclist, desc = "Open diagnostic [Q]uickfix list" },
})

wk.add({
  { "<leader>j", group = "[j]ournal" },
  { "<leader>jj", open_journal_today, desc = "Open today's [j]ournal" },
})
wk.add({
  { "<leader><tab>", group = "[tab]s" },
  { "<leader><tab><tab>", "<cmd>tabnew<CR>", desc = "Create New [tab]" },
  { "<leader><tab><Del>", "<cmd>tabclose<CR>", desc = "[Del]ete Current Tab" },
  { "<leader><tab>n", "<cmd>tabNext<CR>", desc = "[n]ext Tab" },
  { "<leader><tab>p", "<cmd>tabprevious<CR>", desc = "[p]revious Tab" },
  { "<leader><tab>r", "<cmd>tcd -<CR>", desc = "CD to previous directory in current tab" },
})

-- our minimal package manager keymaps, we can expand on these as we add more functionality but for now we just need update and clean commands
wk.add({
  { "<leader>p", group = "[p]ack" },
  {
    "<leader>pu",
    function()
      vim.pack.update()
    end,
    desc = "Update all packages",
  },
  {
    "<leader>pc",
    function()
      vim.pack.del(vim
        .iter(vim.pack.get())
        :filter(function(x)
          return not x.active
        end)
        :map(function(x)
          return x.spec.name
        end)
        :totable())
    end,
    desc = "clean all unused packages",
  },
})

-- Navigation Keymaps that dont use leader keys dont need to be tested with which-key, so we can register them directly
-- largely replaces fancy window management plugins like smart-splits since we dont need tmux integration
vim.keymap.set("n", "<C-h>", "<C-w><C-h>", { desc = "Move focus to the left window" })
vim.keymap.set("n", "<C-l>", "<C-w><C-l>", { desc = "Move focus to the right window" })
vim.keymap.set("n", "<C-j>", "<C-w><C-j>", { desc = "Move focus to the lower window" })
vim.keymap.set("n", "<C-k>", "<C-w><C-k>", { desc = "Move focus to the upper window" })
vim.keymap.set("n", "<C-s>", "<cmd>w<CR>", { desc = "Save current Buffer" })
local function change_scale_factor(delta)
  vim.g.neovide_scale_factor = (vim.g.neovide_scale_factor * delta)
  return nil
end

-- we have to do some special hotkeys for when we are using a GUI client to adjust the scale factor which goes into how we actually zoom in and out
vim.keymap.set("n", "<C-=>", function()
  change_scale_factor(1.25)
end, { desc = "Increase Neovide scale factor" })
vim.keymap.set("n", "<C-->", function()
  change_scale_factor(1 / 1.25)
end, { desc = "Decrease Neovide scale factor" })
return vim.keymap.set("n", "<C-[>", function()
  vim.g.neovide_scale_factor = 1
end, { desc = "Reset Neovide scale factor" })
