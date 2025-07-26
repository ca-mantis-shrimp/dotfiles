(require :config.options)

(local lazypath (.. (_G.vim.fn.stdpath :data) :/lazy/lazy.nvim))

(when (not (_G.vim.loop.fs_stat lazypath))
  (let [lazyrepo "https://github.com/folke/lazy.nvim.git"]
    (_G.vim.fn.system [:git
                       :clone
                       "--filter=blob:none"
                       :--branch=stable
                       lazyrepo
                       lazypath])))

(_G.vim.opt.rtp:prepend lazypath)

(let [lazy (require :lazy)
      setup_opts {:spec [{:import :plugins}]}]
  (lazy.setup setup_opts))

(require :config.keymaps)
(require :config.autocmds)


