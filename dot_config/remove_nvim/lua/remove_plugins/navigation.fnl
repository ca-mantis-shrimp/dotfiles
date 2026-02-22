[{1 :folke/flash.nvim
  :even :VeryLazy
  :opts {}
  :keys [{1 :<leader>j :mode [:n :x :o] 2 #((. (require :flash) :jump))}
         {1 :<leader>J :mode [:n :x :o] 2 #((. (require :flash) :treesitter))}
         {1 :r :mode :o 2 #((. (require :flash) :remote))}
         {1 :R :mode [:o :x] 2 #((. (require :flash) :treesitter_search))}
         {1 :<c-s> :mode :c 2 #((. (require :flash) :toggle))}]}
 {1 :stevearc/oil.nvim
  :opts {}
  :keys [{1 :<leader>O 2 :<cmd>Oil<cr> :desc "Open Oil"}]}
 {1 :mrjones2014/smart-splits.nvim
  :opts {}
  :keys [{1 :<c-h> 2 #((. (require :smart-splits) :move_cursor_left))}
         {1 :<c-j> 2 #((. (require :smart-splits) :move_cursor_down))}
         {1 :<c-k> 2 #((. (require :smart-splits) :move_cursor_up))}
         {1 :<c-l> 2 #((. (require :smart-splits) :move_cursor_right))}
         {1 :<A-h> 2 #((. (require :smart-splits) :resize_left))}
         {1 :<A-j> 2 #((. (require :smart-splits) :resize_down))}
         {1 :<A-k> 2 #((. (require :smart-splits) :resize_up))}
         {1 :<A-l> 2 #((. (require :smart-splits) :resize_right))}
         {1 :<leader><leader>h 2 #((. (require :smart-splits) :swap_buf_left))}
         {1 :<leader><leader>j 2 #((. (require :smart-splits) :swap_buf_down))}
         {1 :<leader><leader>k 2 #((. (require :smart-splits) :swap_buf_up))}
         {1 :<leader><leader>l
          2 #((. (require :smart-splits) :swap_buf_right))}]}]

