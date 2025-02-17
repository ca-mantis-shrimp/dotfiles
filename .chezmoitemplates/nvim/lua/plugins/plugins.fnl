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
 {1 :3rd/image.nvim
  :opts {:processor :magick_cli}
  :cond #(not _G.vim.g.neovide)}]

