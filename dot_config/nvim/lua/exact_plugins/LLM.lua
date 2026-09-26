vim.pack.add({
  "https://github.com/github/copilot.vim", -- For easy copilot setup
  "https://github.com/folke/sidekick.nvim", -- a nice, minimal ui/terminal wrapper
  "https://github.com/linw1995/nvim-mcp", -- mcp server that assumes nvim-mcp is already installed
})

-- Replicate nvim-mcp's default pipe path but with a WSL-safe socket dir check.
-- XDG_RUNTIME_DIR may be set but not yet created under WSL (no systemd-logind session),
-- so we must verify it exists before using it.
local function get_mcp_socket_dir()
  local xdg = os.getenv("XDG_RUNTIME_DIR")
  if xdg and xdg ~= "" and vim.fn.isdirectory(xdg) == 1 then
    return xdg
  end
  local tmpdir = os.getenv("TMPDIR")
  if tmpdir and tmpdir ~= "" then
    return tmpdir
  end
  return "/tmp"
end

local function get_git_root()
  local handle = io.popen("git rev-parse --show-toplevel 2>/dev/null")
  if not handle then return nil end
  local result = handle:read("*a")
  handle:close()
  result = result:gsub("^%s+", ""):gsub("%s+$", "")
  return result ~= "" and result or nil
end

local function generate_pipe_path()
  local root = get_git_root() or vim.fn.getcwd()
  local escaped = root:gsub("^%s+", ""):gsub("%s+$", ""):gsub("/", "%%")
  return string.format("%s/nvim-mcp.%s.%d.sock", get_mcp_socket_dir(), escaped, vim.fn.getpid())
end

require("nvim-mcp").setup({ pipe = generate_pipe_path() })

require("sidekick").setup()
vim.keymap.set({ "n", "i", "x" }, "<tab>", function()
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
