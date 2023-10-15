return {

{
  "nvim-neotest/neotest",
  optional = true,
  dependencies = {
    "nvim-neotest/neotest-python",
  },
  opts = {
    adapters = {
      ["neotest-python"] = {
        -- Here you can specify the settings for the adapter, i.e.
        runner = "pytest",
        python = vim.g.python_host_prog,
      },
    },
  },
},

{
"mfussenegger/nvim-dap-python",
config = function()
  require("dap-python").setup(vim.g.python_host_prog)
  require('dap-python').test_runner = 'pytest'
  require('dap-python').resolve_python = function()
      return vim.g.python_host_prog
  end
end,
},

}