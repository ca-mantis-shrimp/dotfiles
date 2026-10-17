vim.api.nvim_create_autocmd("TextYankPost", {
  desc = "Highlight when yanking text",
  group = vim.api.nvim_create_augroup("highlight-yank", { clear = true }),
  callback = function()
    vim.highlight.on_yank()
  end,
})

vim.api.nvim_create_autocmd("LspAttach", {
  desc = "Toggle inlay hints on attach",
  group = vim.api.nvim_create_augroup("lsp-attach", { clear = true }),
  callback = function(event)
    local client = vim.lsp.get_client_by_id(event.data.client_id)
    if client and client.server_capabilities.inlayHintProvider and vim.lsp.inlay_hint then
      vim.keymap.set("n", "<leader>th", function()
        vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled())
      end, { buffer = event.buf, desc = "LSP: [T]oggle Inlay [H]ints" })
    end
  end,
})


vim.api.nvim_create_autocmd("FileType", {
  desc = "Start treesitter highlighting and folding when a parser is installed",
  group = vim.api.nvim_create_augroup("treesitter-start", { clear = true }),
  callback = function(event)
    local lang = vim.treesitter.language.get_lang(event.match)
    if not lang or not vim.treesitter.language.add(lang) then
      return
    end
    vim.treesitter.start(event.buf, lang)
    local wo = vim.wo[0][0]
    wo.foldexpr = "v:lua.vim.treesitter.foldexpr()"
    wo.foldmethod = "expr"
  end,
})
