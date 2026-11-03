vim.pack.add({
  "https://github.com/folke/sidekick.nvim", -- a nice, minimal ui/terminal wrapper
})

-- Copilot runs as an LSP (options.lua); its ghost text is native inline completion.
-- In insert mode <Tab> goes through blink (blink.lua).
vim.lsp.inline_completion.enable()

require("sidekick").setup({
  cli = {
    -- How the agents show up. layout: "float", "left", "right", "top" or "bottom".
    -- float takes any nvim_open_win option (border, row, col); sizes below 1 are fractions of the screen.
    win = {
      layout = "float",
      float = { width = 0.9, height = 0.9 },
    },
    tools = {
      claude_admin = {
        cmd = { "claude", "--dangerously-skip-permissions" },
      },
      -- The facilitator lives in shpool, not nvim: it outlives this server and always runs from its own repo,
      -- whatever nvim's cwd. -f takes the session from any older view. NVIM is the fixed --listen socket.
      -- shpool gives --cmd a bare PATH (/usr/bin:/bin:...), so a login shell restores ~/.local/bin and the rest.
      facilitator = {
        cmd = {
          "shpool", "attach", "-f",
          "--dir", vim.fn.expand("~/Products/assistant"),
          "--cmd", "bash -lc 'exec env NVIM=/run/user/1000/nvim/server.sock claude --dangerously-skip-permissions'",
          "facilitator",
        },
      },
    },
  },
})
vim.keymap.set({ "n", "x" }, "<tab>", function()
  return require("sidekick").nes_jump_or_apply() or "<tab>"
end, { expr = true, desc = "Goto/Apply Next Edit Suggestion" })
vim.keymap.set({ "n", "t", "i", "x" }, "<c-.>", function()
  require("sidekick.cli").toggle()
end, { desc = "Sidekick Toggle" })
vim.keymap.set("n", "<leader>as", function()
  require("sidekick.cli").select()
end, { desc = "Select CLI" })
vim.keymap.set("n", "<leader>ad", function()
  require("sidekick.cli").close()
end, { desc = "Detach CLI Session" })
vim.keymap.set({ "x", "n" }, "<leader>at", function()
  require("sidekick.cli").send({ msg = "{this}" })
end, { desc = "Send This" })
vim.keymap.set({ "x", "n" }, "<leader>af", function()
  require("sidekick.cli").send({ msg = "{file}" })
end, { desc = "Send File" })
vim.keymap.set({ "x", "n" }, "<leader>av", function()
  require("sidekick.cli").send({ msg = "{selection}" })
end, { desc = "Send Visual Selection" })
vim.keymap.set({ "n", "x" }, "<leader>ap", function()
  require("sidekick.cli").prompt()
end, { desc = "Sidekick Prompt" })
vim.keymap.set("n", "<leader>ac", function()
  require("sidekick.cli").toggle({ name = "claude", focus = true })
end, { desc = "Sidekick Toggle Claude" })
vim.keymap.set("n", "<leader>aa", function()
  require("sidekick.cli").toggle({ name = "facilitator", focus = true })
end, { desc = "Facilitator (persistent, shpool)" })
