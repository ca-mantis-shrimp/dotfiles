{1 :nvim-treesitter/nvim-treesitter
 :lazy false
 :build :TSUpdate
 :config (fn []
           ;; Configure local actions parser for development
           (tset (require :nvim-treesitter.parsers) :actions
                 {:install_info {:path "~/Products/tree-sitter-actions"
                                 :queries :queries}
                  :filetype :actions}))}
