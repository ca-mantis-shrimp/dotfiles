(local M {})

(set M.is_windows (fn []
                    (_G.vim.fn.has :win32)))

(set M.is_vscode (fn []
                   (_G.vim.fn.exists "g:vscode")))

(set M.setup_treesitter_highlight
     (fn [] "Setup Treesitter highlighting"
       (_G.vim.treesitter.start)))

(set M.setup_treesitter_folding
     (fn []
       "Setup Treesitter-based folding"
       (let [wo (. vim.wo 0 0)]
         (tset wo :foldexpr "v:lua.vim.treesitter.foldexpr()")
         (tset wo :foldmethod :expr))))

(set M.setup_treesitter_indentation
     (fn [] "Setup Treesitter-based indentation"
       (tset vim.bo :indentexpr "v:lua.require'nvim-treesitter'.indentexpr()")))

(set M.setup_treesitter_full
     (fn []
       "Setup Treesitter with all features enabled"
       (M.setup_treesitter_highlight)
       (M.setup_treesitter_folding)
       (M.setup_treesitter_indentation)))

M

