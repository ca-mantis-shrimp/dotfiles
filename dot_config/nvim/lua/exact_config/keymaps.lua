local wk = require("which-key")
local workspace = require("config.workspace")

-- By keeping the core keymaps in a which-key invocation we ensure the UI is built properly on startup
wk.add({
  { "<leader>u", group = "[u]i" },
  { "<leader>s", group = "[s]earch" },
  { "<leader>t", group = "[t]est" },
  { "<leader>i", group = "[I]ntentions" },
  { "<leader>m", "<cmd>make<CR>", desc = "Run [m]ake" },
  { "<leader>bd", "<cmd>bd<CR>", desc = "Delete current [b]uffer" },
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
  { "<leader>ca", "<cmd> terminal chezmoi apply<CR>", desc = "Apply chezmoi changes to the system" },
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

wk.add({
  { "<leader>w", group = "[w]orkspace" },
  {
    "<leader>wp",
    function()
      workspace.pick_project()
    end,
    desc = "Open [p]roject workspace",
  },
  {
    "<leader>ws",
    function()
      workspace.save_session()
    end,
    desc = "[s]ave workspace session",
  },
  {
    "<leader>wl",
    function()
      workspace.load_session()
    end,
    desc = "[l]oad workspace session",
  },
})

-- we do these little escape hotkeys to either clear search highlights or to exit terminal mode without having to reach for the escape key twice, which is a common pain point for me when using neovim in the terminal since I have to use escape sequences to get out of terminal mode and it can be a bit finicky
vim.keymap.set("n", "<Esc>", "<cmd>nohlsearch<CR>", { desc = "Remove Search Highlighting on Escape" })
vim.keymap.set("t", "<Esc><Esc>", "<C-\\><C-n>", { desc = "[Esc]ape terminal mode" })
