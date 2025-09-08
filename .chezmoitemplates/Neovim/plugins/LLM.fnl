[{1 :github/copilot.vim}
 {1 :CopilotC-Nvim/CopilotChat.nvim :build "make tiktoken" :opts {}}
 {1 :olimorris/codecompanion.nvim
  :dependencies [{1 :ravitemer/mcphub.nvim
                  :build "npm install -g mcp-hub@latest"
                  :opts {}}]
  :opts {:extensions {:mcphub {:callback :mcphub.extensions.codecompanion
                               :opts {:make_tools true
                                      :show_server_tools_in_chat true
                                      :add_mcp_prefix_to_tool_names false
                                      :show_result_in_chat true
                                      :format_tool nil
                                      :make_vars true
                                      :make_slash_commands true}}
                      :vectorcode {:opts {:tool_group {:enabled true
                                                       :extras {}
                                                       :collapse false}}
                                   :tool_opts {:* {}
                                               :ls {}
                                               :vectorise {}
                                               :query {:max_num {:chunk -1
                                                                 :document -1}}
                                               :default_num {:chunk 50
                                                             :document 10}
                                               :include_stderr false
                                               :use_lsp false
                                               :no_duplicate true
                                               :chunk_mode false
                                               :summarize {:enabled false
                                                           :adapter nil
                                                           :query_argument true}
                                               :file_ls {}
                                               :files_rm {}}}}}
  :keys [{1 :<leader>cc
          2 :<cmd>CodeCompanionChat<CR>
          :desc "CodeCompanion Chat"}
         {1 :<leader>ci
          2 :<cmd>CodeCompanionInline<CR>
          :mode :v
          :desc "CodeCompanion Inline"}]}]

