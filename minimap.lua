return {
  "wfxr/minimap.vim",
  keys = { { "leader>um", "<cmd>MinimapToggle<cr>", desc = "Toggle Minimap" } },
  build = "cargo install --locked code-minimap",
  lazy = false,
}