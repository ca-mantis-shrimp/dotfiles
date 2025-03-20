[{1 :olimorris/codecompanion.nvim
  :lazy true
  :keys [{1 :<leader>uc
          2 "<cmd>CodeCompanionChat Toggle<CR>"
          :desc "[u]i to toggle code completion [c]hat"}
         {1 :<leader>sA
          2 :<cmd>CodeCompanionActions<CR>
          :desc "[s]earch CodeCompanion [a]ctions"}]
  :opts {:strategies {:chat {:adapter :anthropic}
                      :inline {:adapter :anthropic}}}}
 {1 :CopilotC-Nvim/CopilotChat.nvim
  :dependencies [[:github/copilot.vim]]
  :build "make tiktoken"
  :opts {}}]

