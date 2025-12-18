[{1 :github/copilot.vim}
 {1 :olimorris/codecompanion.nvim
  :dependencies [{1 :ravitemer/mcphub.nvim
                  :build "npm install -g mcp-hub@latest"
                  :opts {}}
                 {1 :Davidyz/VectorCode :version "*"}]
  :opts {:interactions {:chat {:adapter :anthropic}
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
          :desc "Add Current Selection to Chat"}]}
 {1 :folke/sidekick.nvim
  :opts {}
  :keys [{1 :<tab>
          2 #(or ((. (require :sidekick) :nex_jump_or_apply)) :<tab>)
          :expr true
          :desc "Goto/Apply Next Edit Suggestions"}
         {1 :<c-.>
          2 #((. (require :sidekick.cli) :toggle))
          :desc "Sidekick Toggle"
          :mode [:n :t :i :x]}
         {1 :<leader>as
          2 #((. (require :sidekick.cli) :select))
          :desc "Select CLI"}
         {1 :<leader>ad
          2 #((. (require :sidekick.cli) :close))
          :desc "detatch a CLI Session"}
         {1 :<leader>at
          2 #((. (require :sidekick.cli) :send) {:msg "{this}"})
          :mode [:x :n]
          :desc "Send This"}
         {1 :<leader>af
          2 #((. (require :sidekick.cli) :send) {:msg "{file}"})
          :mode [:x :n]
          :desc "Send File"}
         {1 :<leader>av
          2 #((. (require :sidekick.cli) :send) {:msg "{selection}"})
          :mode [:x :n]
          :desc "Send Visual Selection"}
         {1 :<leader>ap
          2 #((. (require :sidekick.cli) :prompt))
          :mode [:n :x]
          :desc "Sidekick Select Prompt"}
         {1 :<leader>ac
          2 #((. (require :sidekick.cli) :toggle) {:name :claude :focus true})
          :desc "Sidekick Toggle Claude"}]}]

