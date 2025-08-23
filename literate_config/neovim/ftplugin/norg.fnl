(set _G.vim.opt_local.wrap true)
(set _G.vim.opt_local.spell true)
(set _G.vim.opt_local.spelllang [:en_us])
(set _G.vim.opt_local.conceallevel 2)

(_G.vim.keymap.set :n :<localLeader>nc
                   #((. (require :neorg) :looking-glass.magnify-code-block)))
