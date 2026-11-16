-- Lisp editing: Conjure evaluates against a running REPL (nREPL for Clojure),
-- parinfer keeps parens following indentation so structure edits stay cheap.

-- Conjure's K doc lookup fails in Lua; free K for LSP hover (clojure_lsp covers Clojure docs).
vim.g["conjure#mapping#doc_word"] = false

vim.pack.add({
  "https://github.com/Olical/conjure",
  "https://github.com/gpanders/nvim-parinfer",
})
