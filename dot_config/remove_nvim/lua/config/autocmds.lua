local function _1_()
  return vim.highlight.on_yank()
end
vim.api.nvim_create_autocmd("TextYankPost", {
  desc = "highlight when yanking text",
  group = vim.api.nvim_create_augroup("kickstart-highlight-yank", { clear = true }),
  callback = _1_,
})
local function setup_lsp(event)
  local setup_lsp_map
  local function _2_(keys, func, desc)
    return vim.keymap.set("n", keys, func, { buffer = event.buf, desc = ("LSP: " .. desc) })
  end
  setup_lsp_map = _2_
  setup_lsp_map("<leader>rn", vim.lsp.buf.rename, "[R]e[n]ame")
  setup_lsp_map("<leader>ca", vim.lsp.buf.code_action, "[C]ode [A]ction")
  setup_lsp_map("K", vim.lsp.buf.hover, "Hover Documentation")
  setup_lsp_map("gD", vim.lsp.buf.declaration, "[G]oto [D]eclaration")
  local client = vim.lsp.get_client_by_id(event.data.client_id)
  if client and client.server_capabilities.documentHighlightProvider then
    vim.api.nvim_create_autocmd(
      { "CursorHold", "CursorHoldI" },
      { buffer = event.buf, callback = vim.lsp.buf.document_highlight }
    )
    vim.api.nvim_create_autocmd(
      { "CursorMoved", "CursorMovedI" },
      { buffer = event.buf, callback = vim.lsp.buf.clear_references }
    )
  else
  end
  if client and client.server_capabilities.inlayHintProvider and vim.lsp.inlay_hint then
    local function _4_()
      return vim.lsp.inlay_hint.enable(0, not vim.lsp.inlay_hint.is_enabled())
    end
    return setup_lsp_map("<leader>th", _4_, "[T]oggle Inlay [H]ints")
  else
    return nil
  end
end
vim.api.nvim_create_autocmd(
  "LspAttach",
  { group = vim.api.nvim_create_augroup("lsp-attach", { clear = true }), callback = setup_lsp }
)
local function _6_()
  require("nvim-treesitter.parsers")["actions"] = {
    install_info = { path = "~/Products/platform/tree-sitter-actions", queries = "queries/actions" },
    filetype = "actions",
  }
  return nil
end
return vim.api.nvim_create_autocmd("User", { pattern = "TSUpdate", callback = _6_ })
