vim.pack.add({ "https://github.com/mfussenegger/nvim-lint" })

require("lint").linters_by_ft = {
  markdown = { "markdownlint-cli2" },
}

-- markdownlint-cli2 only discovers config at or below its working directory,
-- so our global ~/.markdownlint-cli2.yaml never applies inside projects. Pass
-- it explicitly as the base config so it holds regardless of where nvim opens.
require("lint").linters["markdownlint-cli2"].args =
  { "--config", vim.fn.expand("~/.markdownlint-cli2.yaml"), "-" }

vim.api.nvim_create_autocmd({ "BufWritePost", "BufReadPost", "InsertLeave" }, {
  group = vim.api.nvim_create_augroup("nvim-lint", { clear = true }),
  callback = function()
    require("lint").try_lint()
  end,
})
