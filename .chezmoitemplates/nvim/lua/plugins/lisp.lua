-- [nfnl] Compiled from lua/plugins/lisp.fnl by https://github.com/Olical/nfnl, do not edit.
return {
	{ "Olical/nfnl", ft = "fennel" },
	{ "Olical/conjure" },
	{ "eraserhd/parinfer-rust", build = "cargo build --release", ft = { "fennel", "hy" } },
}
