-- both mcphub and codecompanion use plenary so we just need to ensure that is present
-- mcphub is shared with avante — setup lives here since this loads first
-- Assumes that the mcp-hub dep was installed globally
vim.pack.add({ "https://github.com/ravitemer/mcphub.nvim" })
require("mcphub").setup()

-- extra deps are nvim-treesitter
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
  extensions = {
    mcphub = {
      callback = "mcphub.extensions.codecompanion",
      opts = {
        make_vars = false,
        make_slash_commands = true,
        show_result_in_chat = true,
      },
    },
  },
})
