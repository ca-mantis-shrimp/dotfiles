-- [nfnl] Compiled from lua/plugins/treesitter.fnl by https://github.com/Olical/nfnl, do not edit.
local function _1_(_, opts)
  require("nvim-treesitter.install")["prefer_git"] = true
  if (_G.vim.fn.has("win32") == 1) then
    require("nvim-treesitter.install")["compilers"] = {"zig"}
  else
  end
  do
    local parser_config = require("nvim-treesitter.parsers").get_parser_configs()
    parser_config["projects"] = {install_info = {url = "~/Products/tree-sitter-projects", files = {"src/parser.c"}}, filetype = "projects"}
  end
  require("nvim-treesitter.configs").setup(opts)
  _G.vim.opt["foldmethod"] = "expr"
  _G.vim.opt["foldexpr"] = "nvim_treesitter#foldexpr()"
  return nil
end
return {"nvim-treesitter/nvim-treesitter", build = ":TSUpdate", opts = {ensure_installed = {"bash", "c", "html", "lua", "luadoc", "markdown", "vim", "vimdoc", "python"}, auto_install = true, highlight = {enable = true}, indent = {enable = true}, incremental_selection = {enable = true, keymaps = {init_selection = "gsi", node_incremental = "gsn", scope_incremental = "gss", node_decremental = "gsd"}}}, dependencies = {"ca-mantis-shrimp/treesitter-projects", dir = "~/Products/tree-sitter-projects/"}, config = _1_}
