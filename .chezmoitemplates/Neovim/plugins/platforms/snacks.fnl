{1 :folke/snacks.nvim
 :priority 1000
 :lazy false
 :dependencies [{1 :folke/persistence.nvim :event :BufReadPre}]
 :opts {:bigfile {:enabled true}
        :dashboard {:sections [{:section :header}
                               {:icon "" :title :Keymaps :section :keys}
                               {:icon ""
                                :title "Recent Files"
                                :section :recent_files}
                               {:icon ""
                                :title :Projects
                                :section :projects}
                               {:icon "" :section :session :title :Sessions}
                               {:section :startup}]}
        :explorer {:enabled true}
        :indent {:enabled true}
        :input {:enabled true}
        :picker {:enabled true}
        :notifier {:enabled true}
        :quickfile {:enabled true}
        :scope {:enabled true}
        :scroll {:enabled true}
        :statuscolumn {:enabled true}
        :words {:enabled true}
        :zen {}}
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
        {1 :<leader>sp 2 #(_G.Snacks.picker.projects) :desc "Search Projects"}
        {1 :<leader>sc 2 #(_G.Snacks.picker.commands) :desc "Search Commands"}
        {1 :<leader>si 2 #(_G.Snacks.picker.icons) :desc "Search Icons"}
        {1 :<leader>sj 2 #(_G.Snacks.picker.jumps) :desc "Search Jumps"}
        {1 :<leader>sd
         2 #(_G.Snacks.picker.diagnostics)
         :desc "Search Diagnostics"}
        {1 :<c-/>
         2 #(_G.Snacks.terminal)
         :desc "Open Horizontal Terminal Window"}
        {1 :<leader>uz 2 #(_G.Snacks.zen) :desc "Zen Mode"}]}

