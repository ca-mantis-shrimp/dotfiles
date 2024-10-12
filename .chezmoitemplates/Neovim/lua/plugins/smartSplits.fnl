{1 :mrjones2014/smart-splits.nvim
 :config true
 :keys [{1 :<A-h>
         2 (fn []
             ((. (require :smart-splits) :resize_left)))
         :desc "Resize Split Left"}
        {1 :<A-j>
         2 (fn []
             ((. (require :smart-splits) :resize_down)))
         :desc "Resize Split Down"}
        {1 :<A-k>
         2 (fn []
             ((. (require :smart-splits) :resize_up)))
         :desc "Resize Split Up"}
        {1 :<A-l>
         2 (fn []
             ((. (require :smart-splits) :resize_right)))
         :desc "Resize Split Right"}
        {1 :<C-h>
         2 (fn []
             ((. (require :smart-splits) :move_cursor_left)))
         :desc "Move Cursor Left"}
        {1 :<C-j>
         2 (fn []
             ((. (require :smart-splits) :move_cursor_down)))
         :desc "Move Cursor Down"}
        {1 :<C-k>
         2 (fn []
             ((. (require :smart-splits) :move_cursor_up)))
         :desc "Move Cursor Up"}
        {1 :<C-l>
         2 (fn []
             ((. (require :smart-splits) :move_cursor_right)))
         :desc "Move Cursor Right"}
        {1 :<leader><leader>h
         2 (fn []
             ((. (require :smart-splits) :swap_buf_left)))
         :desc "Swap Buffer Left"}
        {1 :<leader><leader>j
         2 (fn []
             ((. (require :smart-splits) :swap_buf_up)))
         :desc "Swap Buffer Up"}
        {1 :<leader><leader>k
         2 (fn []
             ((. (require :smart-splits) :swap_buf_down)))
         :desc "Swap Buffer Down"}
        {1 :<leader><leader>l
         2 (fn []
             ((. (require :smart-splits) :swap_buf_right)))
         :desc "Swap Buffer Right"}]}

