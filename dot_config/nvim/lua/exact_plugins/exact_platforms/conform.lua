vim.pack.add({ "https://github.com/stevearc/conform.nvim" })

require("conform").setup({
  formatters_by_ft = {
    lua = { "stylua" },
    markdown = { "markdownlint-cli2" },
    python = { "ruff", "black" },
    clojure = { "cljfmt" },
    json = { "oxfmt", "jq", stop_after_first = true },
    jsonc = { "oxfmt", "jq", stop_after_first = true },
    toml = { "tombi" },
    javascript = { "oxfmt", "js_beautify", stop_after_first = true },
    javascriptreact = { "oxfmt" },
    typescript = { "oxfmt" },
    typescriptreact = { "oxfmt" },
  },
  -- Only where the project declares oxfmt, so its formatting matches the project's check.
  formatters = { oxfmt = { require_cwd = true } },
  format_on_save = { timeout_ms = 500, lsp_format = "fallback" },
})
