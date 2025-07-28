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
                                             (map :gd
                                                  (. (require :telescope.builtin)
                                                     :lsp_definitions)
                                                  "[G]oto [D]efinition")
                                             (map :gr
                                                  (. (require :telescope.builtin)
                                                     :lsp_references)
                                                  "[G]oto [R]eferences")
                                             (map :gI
                                                  (. (require :telescope.builtin)
                                                     :lsp_implementations)
                                                  "[G]oto [I]mplementation")
                                             (map :<leader>D
                                                  (. (require :telescope.builtin)
                                                     :lsp_type_definitions)
                                                  "Type [D]efinition")
                                             (map :<leader>ds
                                                  (. (require :telescope.builtin)
                                                     :lsp_document_symbols)
                                                  "[D]ocument [S]ymbols")
                                             (map :<leader>ws
                                                  (. (require :telescope.builtin)
                                                     :lsp_dynamic_workspace_symbols)
                                                  "[W]orkspace [S]ymbols")
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
                                                                                :callback _G.vim.lsp.buf.clear_references}))
                                             (when (and client
                                                        client.server_capabilities.inlayHintProvider
                                                        _G.vim.lsp.inlay_hint)
                                               (map :<leader>th
                                                    (fn []
                                                      (_G.vim.lsp.inlay_hint.enable 0
                                                                                    (not (_G.vim.lsp.inlay_hint.is_enabled))))
                                                    "[T]oggle Inlay [H]ints")))})

(_G.vim.api.nvim_create_autocmd :BufWritePost
                                {:group (_G.vim.api.nvim_create_augroup :FnlToLuaChezmoi
                                                                        {:clear true})
                                 :pattern (.. (os.getenv :HOME)
                                              :/.local/share/chezmoi/.chezmoitemplates/nvim/*.fnl)
                                 :callback (fn [args]
                                             (let [fnl-path args.file
                                                   lua-path (string.gsub fnl-path
                                                                         "%.fnl$"
                                                                         :.lua)]
                                               (when (_G.vim.loop.fs_stat lua-path)
                                                 (let [buf (_G.vim.fn.bufadd lua-path)]
                                                   (_G.vim.fn.bufload buf)
                                                   (_G.vim.api.nvim_buf_call buf
                                                                             #(_G.vim.cmd :write))
                                                   (_G.vim.cmd (.. "bd! " buf))))))})

