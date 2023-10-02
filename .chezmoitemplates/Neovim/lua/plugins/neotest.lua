return {
  "nvim-neotest/neotest",
  dependencies = {"nvim-neotest/neotest-python", "rouge8/neotest-rust"},
  opts = {
    adapters = {
      ["neotest-rust"] = {},
      ["neotest-python"] = {},
    },
  }
}