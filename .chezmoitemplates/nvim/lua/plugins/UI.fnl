[{1 :folke/which-key.nvim
  :event :VeryLazy
  :keys [{1 :<leader>?
          2 #(. (require :which-key.show) {:global false})
          :desc "Buffer local keymaps (which-key)"}]}
 {1 :folke/snacks.nvim
  :priority 1000
  :lazy false
  :opts {:bigfile {:enabled true}
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
  :keys [{1 :<leader><space>
          2 #(_G.Snacks.picker.smart)
          :desc "Smart Find Files"}
         {1 "<leader>," 2 #(_G.Snacks.picker.buffers) :desc "Search Buffers"}
         {1 :<leader>/ 2 #(_G.Snacks.picker.grep) :desc "Grep Files"}
         {1 "<leader>:"
          2 #(_G.Snacks.picker.command_history)
          :desc "Search Command History"}
         {1 :<leader>N
          2 #(_G.Snacks.picker.notifications)
          :desc "Search Notifications"}
         {1 :<leader>e 2 #(_G.Snacks.explorer) :desc "Open File Explorer"}
         {1 "<leader>\""
          2 #(_G.Snacks.picker.registers)
          :desc "Search Registers"}
         {1 :<leader>sh 2 #(_G.Snacks.picker.help) :desc "Search Help Docs"}
         {1 :<leader>sm 2 #(_G.Snacks.picker.marks) :desc "Search Marks"}
         {1 :<leader>sM 2 #(_G.Snacks.picker.man) :desc "Search Man Pages"}
         {1 :<leader>sk 2 #(_G.Snacks.picker.keymaps) :desc "Search Keymaps"}
         {1 :<leader>sc 2 #(_G.Snacks.picker.commands) :desc "Search Commands"}
         {1 :<leader>si 2 #(_G.Snacks.picker.icons) :desc "Search Icons"}
         {1 :<leader>sj 2 #(_G.Snacks.picker.jumps) :desc "Search Jumps"}
         {1 :<leader>sd
          2 #(_G.Snacks.picker.diagnostics)
          :desc "Search Diagnostics"}]}
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

