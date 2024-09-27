(require :config.options)

(local lazypath (.. (vim.fn.stdpath :data) "/lazy/lazy.nvim"))

(when (not (vim.loop.fs_stat lazypath))
  (let [lazyrepo "https://github.com/folke/lazy.nvim.git"]
    (vim.fn.system [:git :clone "--filter=blob:none" "--branch=stable" lazyrepo lazypath])))

(vim.opt.rtp:prepend lazypath)

(let [lazy (require :lazy)
  setup_opts {
  :dev {:path "~/Products"}
  :rocks {:hererocks true}
  :spec [
    {:import :plugins}
  ]
}
]
  (lazy.setup setup_opts))

(require :config.keymaps)
(require :config.autocmds)
(require :config.tree-sitter_config)
