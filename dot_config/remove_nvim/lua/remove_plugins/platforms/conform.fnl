{1 :stevearc/conform.nvim
 :opts {:formatters_by_ft {:lua [:stylua]
                           :python [:ruff :black]
                           :fennel [:fnlfmt]
                           :clojure [:cljfmt]
                           :json [:jq]
                           :jsonc [:jq]
                           :toml [:tombi]
                           :javascript [:js_beautify]
                           :norg [:injected]}
        :format_on_save {:timeout_ms 500 :lsp_format :fallback}}}

