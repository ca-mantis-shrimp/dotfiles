(let [ts-parsers ((. (require :nvim-treesitter.parsers) :get_parser_configs))]
  (set ts-parsers.projects {:install_info {:url "~/Products/tree-sitter-projects"
                                           :files [:src/parser.c]}
                            :filetype :projects}))

(_G.vim.filetype.add {:extension {:http :http}})

