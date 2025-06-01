[{1 :yetone/avante.nvim
  :even :VeryLazy
  :version false
  :opts {:provider :ollama
         :cursor_applying_provider :groq
         :ollama {:model "deepseek-r1:latest"}
         :behavior {:enable_cursor_planning_mode true}
         :vendors {:groq {:__inherited_from :openai
                          :api_key_name :GROQ_API_KEY
                          :endpoint "https://api.groq.com/openai/v1/"
                          :model :llama-3.3-70b-versatile
                          :max_completion_tokens 32768}}
         :rag_service {:enabled true
                       :host_mount #(os.getenv :HOME)
                       :provider :ollama
                       :llm_model :llama3
                       :embed_model :moic-embed-text
                       :endpoint "http://localhost:11434"}}
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
 {1 :olimorris/codecompanion.nvim :opts {}}]

