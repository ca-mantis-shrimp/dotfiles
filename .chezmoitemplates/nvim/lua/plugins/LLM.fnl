[{1 :yetone/avante.nvim
  :even :VeryLazy
  :version false
  :opts {:provider :ollama :providers {:ollama {:model "deepseek-r1:latest"}}}
  :build :make
  :dependencies {1 :HakonHarnes/img-clip.nvim
                 :even :VeryLazy
                 :opts {:default {:embed_image_as_base64 true
                                  :prompt_for_file_name false
                                  :drag_and_drop {:insert_mode true}}
                        :use_absolute_path true}}}
 {1 :zbirenbaum/copilot.lua
  :config #((. (require :copilot) :setup) {})
  :cmd :Copilot
  :event :InsertEnter}
 {1 :olimorris/codecompanion.nvim :opts {}}
 {1 :joshuavial/aider.nvim
  :opts {:auto_manage_context true :default_bindings true :debug false}}]

