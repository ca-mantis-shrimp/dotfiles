;;; This is the first and primary entry for the neovim configuration
;;; We need to load the options and util functions first since they are not reliant on plugins for what they do or are intended to be run after the plugins are imported
;;;then we set the keymaps and autocmds AFTER we bootstrap and run lazy as those REQUIRE the plugin to be loaded BEFORE they can be set

(fn lazy_bootstrap []
  "Bootstraps lazy.nvim and adds it to RTP if it doesnt already exist"
  (local lazypath (.. (_G.vim.fn.stdpath :data) :/lazy/lazy.nvim))
  (when (not (_G.vim.loop.fs_stat lazypath))
    (let [lazyrepo "https://github.com/folke/lazy.nvim.git"]
      (_G.vim.fn.system [:git
                         :clone
                         "--filter=blob:none"
                         :--branch=stable
                         lazyrepo
                         lazypath])))
  (_G.vim.opt.rtp:prepend lazypath))

(require :config.options)
(require :config.utils)

(lazy_bootstrap)

;; Primarily we are reading specs from the plugins directory of the package.path as well as the platforms subdirectory
;; We use the Dev Path to handle plugins we are developing locally 
(let [lazy (require :lazy)
      setup_opts {:spec [{:import :plugins} {:import :plugins.platforms}]
                  :dev {:path "~/Products"}}]
  (lazy.setup setup_opts))

(require :config.keymaps)
(require :config.autocmds)
