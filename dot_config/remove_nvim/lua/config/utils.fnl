;;; This set of utility functions are run in multiple files so they are kept here for easy, reusable reference
(local M {})

(set M.is_windows (fn [] "Checks if we are currently on the Windows OS"
                    (_G.vim.fn.has :win32)))

(set M.is_vscode (fn [] "Checks if we are currently running in VSCode"
                   (_G.vim.fn.exists "g:vscode")))

(set M.setup_treesitter (let [highlight (fn [] "Setup Treesitter-based folding"
                                          (vim.treesitter.start))
                              folding (fn []
                                        "Setup Treesitter-based folding"
                                        (let [wo (. vim.wo 0 0)]
                                          (tset wo :foldexpr
                                                "v:lua.vim.treesitter.foldexpr()")
                                          (tset wo :foldmethod :expr)))
                              indent (fn []
                                       "Setup Treesitter-based indentation"
                                       (tset vim.bo :indentexpr
                                             "v:lua.require'nvim-treesitter'.indentexpr()"))]
                          {: highlight
                           : folding
                           : indent
                           :full (fn []
                                   "Setup Treesitter with all features enabled"
                                   (highlight)
                                   (folding)
                                   (indent))}))

M
