-- [nfnl] Compiled from lua/config/keymaps.fnl by https://github.com/Olical/nfnl, do not edit.
do
  local wk = require("which-key")
  local function _1_()
    return require("neotest").summary.toggle()
  end
  local function _2_()
    return require("neotest").run.run()
  end
  local function _3_()
    return require("neotest").run.run(_G.vim.fn.expand("%"))
  end
  local function _4_()
    return require("neotest").run.run({suite = true})
  end
  local function _5_()
    return _G.vim.cmd.edit({args = {(_G.vim.fn.fnamemodify(_G.vim.fn.stdpath("data"), ":h") .. "/clhd/main.actions")}})
  end
  local function _6_()
    return _G.vim.diagnostic.goto_prev()
  end
  local function _7_()
    return _G.vim.diagnostic.goto_next()
  end
  local function _8_()
    return _G.vim.diagnostic.setloclist()
  end
  wk.add({{"<leader>c", group = "[C]ode"}, {"<leader>u", group = "[u]i"}, {"<leader>ut", _1_, desc = "[u]i to [t]oggle neotest [s]ummary"}, {"<leader>uc", "<cmd>CodeCompanionChat Toggle<CR>", desc = "[u]i to toggle code completion [c]hat"}, {"<leader>d", group = "[D]ocument"}, {"<leader>r", group = "[r]ename"}, {"<leader>s", group = "[s]earch"}, {"<leader>sA", "<cmd>CodeCompanionActions<CR>", desc = "[s]earch CodeCompanion [a]ctions"}, {"<leader>se", "<cmd>Telescope neorg search_headings<CR>", desc = "Search Headings"}, {"<leader>t", group = "[t]est"}, {"<space>tn", _2_, desc = "[t]est the [n]earest case"}, {"<space>tf", _3_, desc = "[t]est the current [f]ile"}, {"<space>ts", _4_, desc = "[t]est the [s]uite"}, {"<leader>w", group = "[W]orkspace"}, {"<leader>n", group = "[N]eorg"}, {"<leader>nr", "<cmd>Neorg return<CR>", desc = "Return from Neorg Workspace"}, {"<leader>nT", "<cmd>Neorg tangle current-file<CR>", desc = "Tangle Current File"}, {"<leader>ni", "<cmd>Neorg index<CR>", desc = "Go to Index of Neorg Workspace"}, {"<leader>un", "<cmd>NoiceDismiss<cr>", desc = "Dismiss All Notifications"}, {"<leader>i", group = "[I]ntentions"}, {"<leader>ie", _5_, desc = "Edit clearhead actions file"}, {"<leader><tab>", group = "[tab]s"}, {"<leader><tab><tab>", "<cmd>tabnew<CR>", desc = "Create New [tab]"}, {"<leader><tab><Del>", "<cmd>tabclose<CR>", desc = "[Del]ete Current Tab"}, {"<leader><tab>n", "<cmd>tabNext<CR>", desc = "[n]ext Tab"}, {"<leader><tab>p", "<cmd>tabprevious<CR>", desc = "[p]revious Tab"}, {"<leader><tab>r", "<cmd>tcd -<CR>", desc = "CD to previous directory in current tab"}, {"<leader><tab>b", "<cmd>tcd %:p:h<CR>", desc = "CD to [B]uffer Directory"}, {"<leader>h", desc = "Git [H]unk", mode = "v"}, {"<Esc>", "<cmd>nohlsearch<CR>", desc = "Remove Search Highlighting on Escape"}, {"[d", _6_, desc = "Go to previous [D]iagnostic message"}, {"]d", _7_, desc = "Go to next [D]iagnostic message"}, {"<leader>q", _8_, desc = "Open diagnostic [Q]uickfix list"}, {"<Esc><Esc>", "<C-\\><C-n>", mode = "t", desc = "[Esc]ape terminal mode"}, {"<leader>l", "<cmd>Lazy<CR>", desc = "Start Lazy"}})
end
_G.vim.keymap.set("n", "<C-h>", "<C-w><C-h>", {desc = "Move focus to the left window"})
_G.vim.keymap.set("n", "<C-l>", "<C-w><C-l>", {desc = "Move focus to the right window"})
_G.vim.keymap.set("n", "<C-j>", "<C-w><C-j>", {desc = "Move focus to the lower window"})
_G.vim.keymap.set("n", "<C-k>", "<C-w><C-k>", {desc = "Move focus to the upper window"})
local function change_scale_factor(delta)
  _G.vim.g.neovide_scale_factor = (_G.vim.g.neovide_scale_factor * delta)
  return nil
end
local function _9_()
  return change_scale_factor(1.25)
end
_G.vim.keymap.set("n", "<C-=>", _9_)
local function _10_()
  return change_scale_factor((1 / 1.25))
end
_G.vim.keymap.set("n", "<C-->", _10_)
local function _11_()
  _G.vim.g.neovide_scale_factor = 1
  return nil
end
_G.vim.keymap.set("n", "<C-[>", _11_)
return _G.vim.keymap.set("n", "<C-s>", "<cmd>w<CR>", {desc = "Save current Buffer"})
