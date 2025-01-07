[{1 :alker0/chezmoi.vim}
 {1 :weirongxu/plantuml-previewer.vim
  :dependencies [:aklt/plantuml-syntax :tyru/open-browser.vim]}
 {1 :cameron-wags/rainbow_csv.nvim
  :config true
  :ft [:csv
       :tsv
       :csv_semicolon
       :csv_whitespace
       :csv_pipe
       :rfc_csv
       :rfc_semicolon]
  :cmd [:RainboxDelim
        :RainboxDelimSimple
        :RainboxDelimQuoted
        :RainboxMultiDelim]}
 {1 :rest-nvim/rest.nvim}
 {1 :Vigemus/iron.nvim
  :config (fn []
            (let [iron (require :iron.core)]
              (iron.setup {:config {:scratch_repl true
                                    :repl_definition {:sh {:command [:bash]}
                                                      :python {:command [:python3]
                                                               :format (. iron
                                                                          :bracketed_paste_python)}
                                                      :lua {:command [:lua]}
                                                      :lua.chezmoitmpl {:command [:lua]}}
                                    :repl_open_cmd ((. (require :iron.view)
                                                       :bottom) 40)
                                    :highlight {:italic true}
                                    :ignore_blank_lines true}})))}
 {1 :Olical/nfnl :ft :fennel}
 {1 :Olical/conjure}
 {1 :eraserhd/parinfer-rust :build "cargo build --release" :ft [:fennel :hy]}
 {1 :3rd/image.nvim :opts {}}]

