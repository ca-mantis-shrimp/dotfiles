-- Lisp editing: Conjure evaluates against a running REPL (nREPL for Clojure),
-- parinfer keeps parens following indentation so structure edits stay cheap.
vim.pack.add({
  "https://github.com/Olical/conjure",
  "https://github.com/gpanders/nvim-parinfer",
})
