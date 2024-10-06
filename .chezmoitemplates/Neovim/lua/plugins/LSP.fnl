{
1 "neovim/nvim-lspconfig"
:priority 0
:dependencies ["j-hui/fidget.nvim" "folke/neodev.nvim"]
:config (fn []
          (let [servers {
                        :lua_ls {:settings {:Lua {
                        :completion {:callSnippet "Replace"}
                        :diagnostics {:globals ["vim"]}}}}
                        :fennel_ls {}
                        :ruff_lsp {:init_options {:settings {:args {}}}}}

                        ensure_installed (_G.vim.list_extend (_G.vim.tbl_keys (or servers {})) ["stylua"])

                        capabilities (_G.vim.tbl_deep_extend "force" (_G.vim.lsp.protocol.make_client_capabilities) ((. (require "cmp_nvim_lsp") "default_capabilities")))
                        ]

            ((. (require "mason-tool-installer") "setup") {: ensure_installed})

            ((. (require "mason-lspconfig") "setup") {:handlers {1 (fn [server_name]
                                                                     (let [server (or (. servers server_name) {})]

                                                                       (tset server "capabilities" (_G.vim.tbl_deep_extend "force" {} capabilities (or (. server "capabilities") {})))

                                                                       ((. (. (require "lspconfig") server_name) "setup") server)))}})))}
