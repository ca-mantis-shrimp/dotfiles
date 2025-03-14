[{1 :folke/which-key.nvim
  :event :VeryLazy
  :keys [{1 :<leader>?
          2 #((. (require :which-key) :show) {:global false})
          :desc "Buffer local keymaps (which-key)"}]}
 {1 :folke/snacks.nvim
  :priority 1000
  :lazy false
  :opts {;; your configuration comes here
         ;; or leave it empty to use the default settings
         ;; refer to the configuration section below
         :bigfile {:enabled true}
         :dashboard {:enabled true}
         :explorer {:enabled true}
         :indent {:enabled true}
         :input {:enabled true}
         :picker {:enabled true}
         :notifier {:enabled true}
         :quickfile {:enabled true}
         :scope {:enabled true}
         :scroll {:enabled true}
         :statuscolumn {:enabled true}
         :words {:enabled true}}
  :keys [[:<leader><space> #(: :Snacks.picker :smart)]]}
 {1 :folke/noice.nvim
  :event :VeryLazy
  :opts {:lsp {:override {:vim.lsp.util.convert_input_to_markdown_lines true
                          :vim.lsp.util.stylize_markdown true
                          :cmp.entry.get_documentation true}}}
  :presets {:bottom_search true
            :command_palette true
            :long_message_to_split true
            :inc_rename false
            :lsp_doc_border false}}]

