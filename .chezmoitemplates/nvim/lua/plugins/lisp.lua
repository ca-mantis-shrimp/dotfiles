-- [nfnl] lua/plugins/lisp.fnl
return {
	{ "Olical/nfnl", ft = "fennel" },
	{ "Olical/conjure" },
	{ "eraserhd/parinfer-rust", build = "cargo build --release", ft = { "fennel", "hy", "clojure" } },
	{ "https://gitlab.com/HiPhish/rainbow-delimiters.nvim.git" },
}
