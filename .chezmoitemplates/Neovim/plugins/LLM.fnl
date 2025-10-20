[{1 :github/copilot.vim}
 {1 :CopilotC-Nvim/CopilotChat.nvim :build "make tiktoken" :opts {}}
 {1 :olimorris/codecompanion.nvim
  :dependencies [{1 :ravitemer/mcphub.nvim
                  :build "npm install -g mcp-hub@latest"
                  :opts {}}
                 {1 :Davidyz/VectorCode :version "*"}]
  :opts {:strategies {:chat {:adapter :anthropic}
                      :inline {:adapter :anthropic}
                      :cmd {:adapter :anthropic}}
         :extensions {:mcphub {:callback :mcphub.extensions.codecompanion
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
                                               :files_rm {}}}}
         :adapters {:acp {:claude_code #(. (require :codecompanion.adapters)
                                           :extend
                                           [:claude_code
                                            {:env {:CLAUDE_CODE_AUTH_TOKEN :ANTHROPIC_API_KEY}}])}}
         :memory {:opts {:chat {:enabled true}}}}
  :keys [{1 :<leader>uc
          2 "<cmd>CodeCompanionChat Toggle<CR>"
          :desc "Toggle [u]i for [c]ode companion"}
         {1 :<leader>sC
          2 :<cmd>CodeCompanionActions<CR>
          :desc "[s]earch [C]odeCompanion Actions"}
         {1 :ga
          2 "<cmd>CodeCompanionChat Add<CR>"
          :mode :v
          :desc "Add Current Selection to Chat"}]}]

