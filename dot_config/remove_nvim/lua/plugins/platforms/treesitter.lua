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

    vim.cmd("TSUpdate")
  end,
})

vim.pack.add({ "https://github.com/nvim-treesitter/nvim-treesitter" })
