local function register_local_parsers()
  local ok, parsers = pcall(require, "nvim-treesitter.parsers")
  if not ok then
    return
  end

  parsers.actions = {
    install_info = {
      path = vim.fn.expand("~/Products/platform/tree-sitter-actions"),
      queries = "queries/actions",
    },
    filetype = "actions",
  }
end

vim.api.nvim_create_autocmd("PackChanged", {
  callback = function(ev)
    local name = ev.data.spec.name
    local kind = ev.data.kind

    if name ~= "nvim-treesitter" or (kind ~= "install" and kind ~= "update") then
      return
    end

    if not ev.data.active then
      vim.cmd.packadd("nvim-treesitter")
    end

    register_local_parsers()
    vim.cmd("TSUpdate")
  end,
})

vim.pack.add({ "https://github.com/nvim-treesitter/nvim-treesitter" })

register_local_parsers()
