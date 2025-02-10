-- [nfnl] Compiled from lua/config/tree-sitter_config.fnl by https://github.com/Olical/nfnl, do not edit.
do
  local ts_parsers = require("nvim-treesitter.parsers").get_parser_configs()
  ts_parsers.projects = {install_info = {url = "~/Products/tree-sitter-projects", files = {"src/parser.c"}}, filetype = "projects"}
end
return _G.vim.filetype.add({extension = {http = "http"}})
