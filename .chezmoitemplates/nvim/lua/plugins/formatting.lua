-- [nfnl] lua/plugins/formatting.fnl
return {"stevearc/conform.nvim", opts = {formatters_by_ft = {lua = {"stylua"}, python = {"ruff", "black"}, fennel = {"fnlfmt"}, clojure = {"cljfmt"}}, format_on_save = {timeout_ms = 500, lsp_format = "fallback"}}}
