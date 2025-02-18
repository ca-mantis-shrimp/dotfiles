-- [nfnl] Compiled from lua/plugins/testing.fnl by https://github.com/Olical/nfnl, do not edit.
local function _1_()
  return require("neotest").setup({adapters = {require("neotest-python")({dap = {justMyCode = false}}), require("neotest-plenary")}})
end
return {"nvim-neotest/neotest", dependencies = {"nvim-neotest/nvim-nio", "antoinemadec/FixCursorHold.nvim", "nvim-neotest/neotest-python", "nvim-neotest/neotest-plenary"}, config = _1_}
