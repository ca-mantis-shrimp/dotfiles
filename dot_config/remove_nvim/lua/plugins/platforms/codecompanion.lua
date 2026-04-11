-- both mcphub and codecompanion use plenary so we just need to ensure that is present
-- For now mcphub is only used by codecompanion so we are putting it here
-- Assumes that the mcp-hub dep was installed globally
vim.pack.add({ "https://github.com/ravitemer/mcphub.nvim" })
require("mcphub").setup()

-- extra deps are nvim-treesitter
vim.pack.add({ "https://github.com/olimorris/codecompanion.nvim" })

require("codecompanion").setup({
  extensions = {
    mcphub = {
      callback = "mcphub.extensions.codecompanion",
      opts = {
        -- MCP Tools
        make_tools = true, -- Make individual tools (@server__tool) and server groups (@server) from MCP servers
        show_server_tools_in_chat = true, -- Show individual tools in chat completion (when make_tools=true)
        add_mcp_prefix_to_tool_names = false, -- Add mcp__ prefix (e.g `@mcp__github`, `@mcp__neovim__list_issues`)
        show_result_in_chat = true, -- Show tool results directly in chat buffer
        format_tool = nil, -- function(tool_name:string, tool: CodeCompanion.Agent.Tool) : string Function to format tool names to show in the chat buffer
        -- MCP Resources
        make_vars = false, -- Convert MCP resources to #variables for prompts, currently NOT working with codecompanion so it needs to be turned off
        -- MCP Prompts
        make_slash_commands = true, -- Add MCP prompts as /slash commands
      },
    },
  },
})
