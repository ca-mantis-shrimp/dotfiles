-- [nfnl] neovim/config/autocmds.fnl
local function _1_()
  return _G.vim.highlight.on_yank()
end
_G.vim.api.nvim_create_autocmd("TextYankPost", {desc = "highlight when yanking text", group = _G.vim.api.nvim_create_augroup("kickstart-highlight-yank", {clear = true}), callback = _1_})
local function setup_lsp(event)
  local setup_lsp_map
  local function _2_(keys, func, desc)
    return _G.vim.keymap.set("n", keys, func, {buffer = event.buf, desc = ("LSP: " .. desc)})
  end
  setup_lsp_map = _2_
  setup_lsp_map("<leader>rn", _G.vim.lsp.buf.rename, "[R]e[n]ame")
  setup_lsp_map("<leader>ca", _G.vim.lsp.buf.code_action, "[C]ode [A]ction")
  setup_lsp_map("K", _G.vim.lsp.buf.hover, "Hover Documentation")
  setup_lsp_map("gD", _G.vim.lsp.buf.declaration, "[G]oto [D]eclaration")
  local client = _G.vim.lsp.get_client_by_id(event.data.client_id)
  if (client and client.server_capabilities.documentHighlightProvider) then
    _G.vim.api.nvim_create_autocmd({"CursorHold", "CursorHoldI"}, {buffer = event.buf, callback = _G.vim.lsp.buf.document_highlight})
    _G.vim.api.nvim_create_autocmd({"CursorMoved", "CursorMovedI"}, {buffer = event.buf, callback = _G.vim.lsp.buf.clear_references})
  else
  end
  if (client and client.server_capabilities.inlayHintProvider and _G.vim.lsp.inlay_hint) then
    local function _4_()
      return _G.vim.lsp.inlay_hint.enable(0, not _G.vim.lsp.inlay_hint.is_enabled())
    end
    return setup_lsp_map("<leader>th", _4_, "[T]oggle Inlay [H]ints")
  else
    return nil
  end
end
return _G.vim.api.nvim_create_autocmd("LspAttach", {group = _G.vim.api.nvim_create_augroup("lsp-attach", {clear = true}), callback = setup_lsp})
