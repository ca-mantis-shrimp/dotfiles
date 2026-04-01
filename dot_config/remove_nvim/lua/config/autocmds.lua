vim.api.nvim_create_autocmd("TextYankPost", {
  desc = "Highlight when yanking text",
  group = vim.api.nvim_create_augroup("highlight-yank", { clear = true }),
  callback = function()
    vim.highlight.on_yank()
  end,
})

vim.api.nvim_create_autocmd("LspAttach", {
  desc = "Set LSP keymaps and features on attach",
  group = vim.api.nvim_create_augroup("lsp-attach", { clear = true }),
  callback = function(event)
    local map = function(keys, func, desc)
      vim.keymap.set("n", keys, func, { buffer = event.buf, desc = "LSP: " .. desc })
    end

    map("<leader>rn", vim.lsp.buf.rename, "[R]e[n]ame")
    map("<leader>ca", vim.lsp.buf.code_action, "[C]ode [A]ction")
    map("K", vim.lsp.buf.hover, "Hover Documentation")
    map("gD", vim.lsp.buf.declaration, "[G]oto [D]eclaration")

    local client = vim.lsp.get_client_by_id(event.data.client_id)

    if client and client.server_capabilities.documentHighlightProvider then
      vim.api.nvim_create_autocmd({ "CursorHold", "CursorHoldI" }, {
        buffer = event.buf,
        callback = vim.lsp.buf.document_highlight,
      })
      vim.api.nvim_create_autocmd({ "CursorMoved", "CursorMovedI" }, {
        buffer = event.buf,
        callback = vim.lsp.buf.clear_references,
      })
    end

    if client and client.server_capabilities.inlayHintProvider and vim.lsp.inlay_hint then
      map("<leader>th", function()
        vim.lsp.inlay_hint.enable(0, not vim.lsp.inlay_hint.is_enabled())
      end, "[T]oggle Inlay [H]ints")
    end
  end,
})

vim.api.nvim_create_autocmd("User", {
  desc = "Register custom tree-sitter parser for actions filetype",
  pattern = "TSUpdate",
  callback = function()
    require("nvim-treesitter.parsers")["actions"] = {
      install_info = { path = "~/Products/platform/tree-sitter-actions", queries = "queries/actions" },
      filetype = "actions",
    }
  end,
})

vim.api.nvim_create_autocmd("BufEnter", {
  desc = "Auto tcd to project root on buffer enter",
  group = vim.api.nvim_create_augroup("auto-rootdir", { clear = true }),
  callback = function()
    local root = vim.fs.root(0, { ".git", "_darcs", ".hg", ".bzr", ".svn", "package.json", "Makefile" })
    if root then
      vim.cmd("tcd " .. vim.fn.fnameescape(root))
    end
  end,
})
