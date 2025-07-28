(_G.vim.api.nvim_create_autocmd :TextYankPost
                                {:desc "highlight when yanking text"
                                 :group (_G.vim.api.nvim_create_augroup :kickstart-highlight-yank
                                                                        {:clear true})
                                 :callback (fn []
                                             (_G.vim.highlight.on_yank))})

(_G.vim.api.nvim_create_autocmd :LspAttach
                                {:group (_G.vim.api.nvim_create_augroup :kickstart-lsp-attach
                                                                        {:clear true})
                                 :callback (fn [event]
                                             (local map
                                                    (fn [keys func desc]
                                                      (_G.vim.keymap.set :n
                                                                         keys
                                                                         func
                                                                         {:buffer event.buf
                                                                          :desc (.. "LSP: "
                                                                                    desc)})))
                                             (map :<leader>rn
                                                  _G.vim.lsp.buf.rename
                                                  "[R]e[n]ame")
                                             (map :<leader>ca
                                                  _G.vim.lsp.buf.code_action
                                                  "[C]ode [A]ction")
                                             (map :K _G.vim.lsp.buf.hover
                                                  "Hover Documentation")
                                             (map :gD
                                                  _G.vim.lsp.buf.declaration
                                                  "[G]oto [D]eclaration")
                                             (map :<leader>th
                                                  (fn []
                                                    (_G.vim.lsp.inlay_hint.enable 0
                                                                                  (not (_G.vim.lsp.inlay_hint.is_enabled))))
                                                  "[T]oggle Inlay [H]ints")
                                             (local client
                                                    (_G.vim.lsp.get_client_by_id event.data.client_id))
                                             (when (and client
                                                        client.server_capabilities.documentHighlightProvider)
                                               (_G.vim.api.nvim_create_autocmd [:CursorHold
                                                                                :CursorHoldI]
                                                                               {:buffer event.buf
                                                                                :callback _G.vim.lsp.buf.document_highlight})
                                               (_G.vim.api.nvim_create_autocmd [:CursorMoved
                                                                                :CursorMovedI]
                                                                               {:buffer event.buf
                                                                                :callback _G.vim.lsp.buf.clear_references})))})

