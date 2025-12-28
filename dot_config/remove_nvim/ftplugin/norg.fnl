((. (require :config.utils) :setup_treesitter_full))

(set _G.vim.opt_local.wrap true)
(set _G.vim.opt_local.spell true)
(set _G.vim.opt_local.spelllang [:en_us])
(set _G.vim.opt_local.conceallevel 2)

(_G.vim.keymap.set :n :<localLeader>gf
                   #((. (require :conform) :format) {:formatters [:injected]})
                   {:buffer true :desc "Format norg code blocks"})

