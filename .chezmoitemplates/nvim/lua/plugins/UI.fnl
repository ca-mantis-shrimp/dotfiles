[{1 :folke/which-key.nvim
  :event :VeryLazy
  :keys [{1 :<leader>?
          2 #((. (require :which-key) :show) {:global false})
          :desc "Buffer local keymaps (which-key)"}]}
 {1 :folke/noice.nvim
  :event :VeryLazy
  :opts {}
  :dependencies [:MunifTanjim/nui.nvim :rcarriga/nvim-notify]}
 {1 :folke/todo-comments.nvim
  :event :VimEnter
  :dependencies [:nvim-lua/plenary.nvim]
  :opt {:sign false}}
 {1 :nvimdev/dashboard-nvim
  :event :VimEnter
  :config #((. (require :dashboard) :setup) {})
  :dependencies [:nvim-tree/nvim-web-devicons]}]

