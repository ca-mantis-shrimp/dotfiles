-- [nfnl] dot_config/remove_nvim/lua/remove_plugins/lisp.fnl
return {{"Olical/nfnl", ft = "fennel"}, {"Olical/conjure", branch = "main", dependencies = {{"clojure-vim/vim-jack-in"}}}, {"eraserhd/parinfer-rust", build = "cargo build --release", ft = {"fennel", "hy", "clojure"}}, {"https://gitlab.com/HiPhish/rainbow-delimiters.nvim.git"}}
