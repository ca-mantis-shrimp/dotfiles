local wk = require("which-key")

local function journal_path(offset)
  local date = os.date("*t", os.time() + offset * 86400)
  local path = vim.fn.expand(
    string.format("~/journal/years/%04d/%02d/%02d.md", date.year, date.month, date.day)
  )
  vim.fn.mkdir(vim.fn.fnamemodify(path, ":h"), "p")
  if vim.fn.filereadable(path) == 0 then
    vim.fn.writefile({ string.format("# %04d-%02d-%02d", date.year, date.month, date.day), "" }, path)
  end
  return path
end

local function open_journal(offset)
  vim.cmd.tabedit(journal_path(offset))
end

local journal_win = nil

local function toggle_today()
  if journal_win and vim.api.nvim_win_is_valid(journal_win) then
    local buf = vim.api.nvim_win_get_buf(journal_win)
    if vim.bo[buf].modified then
      vim.api.nvim_buf_call(buf, function() vim.cmd.write() end)
    end
    vim.api.nvim_win_close(journal_win, false)
    journal_win = nil
    return
  end

  local buf = vim.fn.bufadd(journal_path(0))
  vim.fn.bufload(buf)
  vim.bo[buf].bufhidden = "wipe"

  local width = math.floor(vim.o.columns * 0.8)
  local height = math.floor(vim.o.lines * 0.8)
  journal_win = vim.api.nvim_open_win(buf, true, {
    relative = "editor",
    width = width,
    height = height,
    col = math.floor((vim.o.columns - width) / 2),
    row = math.floor((vim.o.lines - height) / 2),
    border = "rounded",
    title = " Journal ",
    title_pos = "center",
  })
  vim.keymap.set("n", "q", toggle_today, { buffer = buf, desc = "Close journal" })
end

-- By keeping the core keymaps in a which-key invocation we ensure the UI is built properly on startup
wk.add({
  { "<leader>u", group = "[u]i" },
  { "<leader>s", group = "[s]earch" },
  { "<leader>t", group = "[t]est" },
  { "<leader>i", group = "[I]ntentions" },
  { "<leader>w", group = "[w]orkspace" },
  { "<leader>m", "<cmd>make<CR>", desc = "Run [m]ake" },
  { "<leader>bd", "<cmd>bd<CR>", desc = "Delete current [b]uffer" },
})

wk.add({
  {
    "<leader>wp",
    function()
      require("config.workspace").pick_project()
    end,
    desc = "Open [p]roject workspace",
  },
  { "<leader>ws", "<cmd>SessionSave<CR>", desc = "[s]ave workspace session" },
  { "<leader>wc", "<cmd>ProjectClose<CR>", desc = "[c]lose workspace" },
  { "<leader>wq", "<cmd>SessionQuit<CR>", desc = "save and [q]uit workspace" },
})

-- lsp hotkeys need to be defined separately but we can use existing APIs to do the work which is why we dont need an autocmd for these they just dont work until an lsp client is attached to the buffer and then they work without any extra configuration
wk.add({
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

-- my cute journalin system in a single hotkey
wk.add({
  { "<leader>j", group = "[j]ournal" },
  {
    "<leader>jt",
    toggle_today,
    desc = "[j]ournal [t]oggle today",
  },
  {
    "<leader>jy",
    function()
      open_journal(-1)
    end,
    desc = "[j]ournal for [y]esterday",
  },
  {
    "<leader>jT",
    function()
      open_journal(1)
    end,
    desc = "[j]ournal for [T]omorrow",
  },
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
  { "<leader>pr", "<cmd>restart<CR>", desc = "Restart Neovim to apply changes" },
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
vim.keymap.set("n", "<C-[>", function()
  vim.g.neovide_scale_factor = 1
end, { desc = "Reset Neovide scale factor" })

-- we do these little escape hotkeys to either clear search highlights or to exit terminal mode without having to reach for the escape key twice, which is a common pain point for me when using neovim in the terminal since I have to use escape sequences to get out of terminal mode and it can be a bit finicky
vim.keymap.set("n", "<Esc>", "<cmd>nohlsearch<CR>", { desc = "Remove Search Highlighting on Escape" })
vim.keymap.set("t", "<Esc><Esc>", "<C-\\><C-n>", { desc = "[Esc]ape terminal mode" })
