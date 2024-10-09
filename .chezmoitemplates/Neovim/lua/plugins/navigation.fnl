[{1 :ThePrimeagen/harpoon :branch :harpoon2 :lazy true :config true}
 {1 :folke/flash.nvim
  :even :VeryLazy
  :opts {}
  :keys [{1 :<leader>j :mode [:n :x :o] 2 #((. (require :flash) :jump))}
         {1 :<leader>J :mode [:n :x :o] 2 #((. (require :flash) :treesitter))}
         {1 :r :mode :o 2 #((. (require :flash) :remote))}
         {1 :R :mode [:o :x] 2 #((. (require :flash) :treesitter_search))}
         {1 :<c-s> :mode :c 2 #((. (require :flash) :toggle))}]}
 {1 :stevearc/oil.nvim
  :opts {}
  :keys [{1 :<leader>O 2 :<cmd>Oil<cr> :desc "Open Oil"}]}]

