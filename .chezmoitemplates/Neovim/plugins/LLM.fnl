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
                                      :make_slash_commands true}}}}
  :keys [{1 :<leader>cc
          2 :<cmd>CodeCompanionChat<CR>
          :desc "CodeCompanion Chat"}
         {1 :<leader>ci
          2 :<cmd>CodeCompanionInline<CR>
          :mode :v
          :desc "CodeCompanion Inline"}]}]

