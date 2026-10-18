-- codecompanion uses plenary (libs.lua); extra deps are nvim-treesitter
vim.pack.add({ "https://github.com/olimorris/codecompanion.nvim" })

require("codecompanion").setup({
  adapters = {
    acp = {
      -- requires BOTH claude code and claude-acp-adapter be installed locally
      claude_code = function()
        return require("codecompanion.adapters").extend("claude_code", {
          env = {
            -- leverages pass to securely pass the oauth token to the adapter
            CLAUDE_CODE_OAUTH_TOKEN = "cmd: pass llm/anthropic/pro",
          },
        })
      end,
    },
  },
})
