[{1 :tpope/vim-dadbod
  :build #(_G.vim.cmd (string.format "helptags %s"
                                     (.. (_G.vim.fn.stdpath :data)
                                         :/lazy/dadbod/doc)))}]

