local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  -- stylua: ignore
  vim.fn.system({ "git", "clone", "--filter=blob:none", "https://github.com/folke/lazy.nvim.git", "--branch=stable",
    lazypath })
end
vim.opt.rtp:prepend(vim.env.LAZY or lazypath)

local spec_list = {
  { "LazyVim/LazyVim", import = "lazyvim.plugins" },
  {{- if ne .chezmoi.hostname "USMINDARBURGES1" }}
  { import = "lazyvim.plugins.extras.coding.copilot" },
  {{- end }}
  { import = "lazyvim.plugins.extras.util.project" },
  { import = "lazyvim.plugins.extras.ui.mini-animate" },
  { import = "lazyvim.plugins.extras.ui.edgy" },
  { import = "lazyvim.plugins.extras.util.mini-hipatterns" },
  {import = "lazyvim.plugins.extras.dap.core"},
  {import = "lazyvim.plugins.extras.test.core"},
  { import = "lazyvim.plugins.extras.vscode" },
  {import = "lazyvim.plugins.extras.editor.flash"},
  { import = "plugins" },
}

local performance_settings = {
  rtp = {
    disabled_plugins = {
      "gzip",
      "tarPlugin",
      "tohtml",
      "tutor",
      "zipPlugin",
    },
  },
}

require("lazy").setup({
  spec = spec_list,
  defaults = {
    lazy = false,
    version = false,
  },
  install = { colorscheme = { "tokyonight", "habamax" } },
  checker = { enabled = true },
  performance = performance_settings,
})
