[{1 :mfussenegger/nvim-dap
  :dependencies [:rcarriga/nvim-dap-ui
                 :theHamsta/nvim-dap-virtual-text
                 :nvim-neotest/nvim-nio]
  :config (fn []
            (let [dap (require :dap)
                  dapui (require :dapui)
                  virtual-text (require :nvim-dap-virtual-text)]
              
              ;; Setup dap-ui
              (dapui.setup)
              
              ;; Setup virtual text
              (virtual-text.setup)
              
              ;; Auto open/close dap-ui
              (dap.listeners.after.event_initialized.dapui_config
                (fn [] (dapui.open)))
              (dap.listeners.before.event_terminated.dapui_config
                (fn [] (dapui.close)))
              (dap.listeners.before.event_exited.dapui_config
                (fn [] (dapui.close)))
              
              ;; Rust configuration with codelldb
              (set dap.adapters.codelldb
                   {:type :server
                    :port "${port}"
                    :executable {:command :codelldb
                                 :args [:--port "${port}"]}})
              
              (set dap.configurations.rust
                   [{:name "Launch"
                     :type :codelldb
                     :request :launch
                     :program (fn []
                                (_G.vim.fn.input "Path to executable: "
                                                  (.. (_G.vim.fn.getcwd) "/target/debug/")
                                                  :file))
                     :cwd "${workspaceFolder}"
                     :stopOnEntry false}
                    {:name "Attach to process"
                     :type :codelldb
                     :request :attach
                     :pid (fn []
                            (tonumber (_G.vim.fn.input "Process ID: ")))}])
              
              ;; Key mappings
              (let [map _G.vim.keymap.set]
                (map :n :<F5> dap.continue {:desc "DAP Continue"})
                (map :n :<F10> dap.step_over {:desc "DAP Step Over"})
                (map :n :<F11> dap.step_into {:desc "DAP Step Into"})
                (map :n :<F12> dap.step_out {:desc "DAP Step Out"})
                (map :n :<leader>db dap.toggle_breakpoint {:desc "DAP Toggle Breakpoint"})
                (map :n :<leader>dB (fn [] (dap.set_breakpoint (_G.vim.fn.input "Breakpoint condition: ")))
                     {:desc "DAP Conditional Breakpoint"})
                (map :n :<leader>dr dap.repl.open {:desc "DAP Open REPL"})
                (map :n :<leader>dl dap.run_last {:desc "DAP Run Last"})
                (map :n :<leader>du dapui.toggle {:desc "DAP Toggle UI"})))))}]
