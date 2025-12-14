(local M {})

(fn M.verify-norg-buffer [bufnr]
  "Check if the given buffer is a .norg file. Returns bufname or nil + error."
  (let [bufname (vim.api.nvim_buf_get_name bufnr)]
    (if (bufname:match "%.norg$")
        bufname
        (values nil "Not a .norg file!"))))

(fn M.save-if-modified [bufnr]
  "Save buffer if it has unsaved changes. Returns true on success."
  (when (. vim.bo bufnr :modified)
    (vim.notify "Saving buffer before tangling..." vim.log.levels.INFO)
    (vim.api.nvim_buf_call bufnr (fn [] (vim.cmd.write))))
  true)

(fn M.get-tangle-metadata [bufnr]
  "Get tangle metadata from the current norg buffer. Returns tangle path or nil + error."
  (let [(ok neorg) (pcall require :neorg)]
    (if (not ok)
        (values nil "Neorg not available")
        (let [ts (neorg.modules.get_module :core.integrations.treesitter)]
          (if ts
              (let [metadata (ts.get_document_metadata bufnr)]
                (if (and metadata metadata.tangle)
                    metadata.tangle
                    (values nil "No tangle directive in document metadata")))
              (values nil "Neorg treesitter module not loaded"))))))

(fn M.tangle-current-file []
  "Run :Neorg tangle current-file command. Returns true or nil + error."
  (let [(ok err) (pcall vim.cmd "Neorg tangle current-file")]
    (if ok
        ;; Give neorg a moment to finish async file writes
        (do
          (vim.wait 100) true)
        (values nil (.. "Tangle command failed: " (tostring err))))))

(fn M.compile-fennel [filepath]
  "Compile a fennel file to lua using nfnl. Returns true or nil + error."
  (let [(ok nfnl) (pcall require :nfnl.api)]
    (if (not ok)
        (do
          (vim.notify "nfnl not available, skipping compilation"
                      vim.log.levels.WARN)
          true)
        ;; Not an error, just skip
        (let [compile-file (. nfnl :compile-file)
              dir (vim.fn.fnamemodify filepath ":h")
              result (compile-file {:path filepath : dir})]
          (if (= result.status :ok)
              true
              (values nil
                      (or result.error
                          (.. "nfnl compilation failed for " filepath))))))))

(fn M.format-lua [filepath]
  "Format a lua file using conform in a hidden buffer. Returns true or nil + error."
  (let [(ok conform) (pcall require :conform)]
    (if (not ok)
        (do
          (vim.notify "conform not available, skipping format"
                      vim.log.levels.WARN)
          true)
        ;; Not an error, just skip
        ;; Load file into hidden buffer, format, save, close
        (let [lua-bufnr (vim.fn.bufadd filepath)]
          (vim.fn.bufload lua-bufnr)
          (conform.format {:bufnr lua-bufnr :async false})
          (vim.api.nvim_buf_call lua-bufnr (fn [] (vim.cmd.write)))
          (vim.api.nvim_buf_delete lua-bufnr {:force true :unload true})
          true))))

(fn M.process-fennel-file [filepath]
  "Compile and format a fennel file. Returns true or nil + error."
  (let [(ok err) (M.compile-fennel filepath)]
    (if (not ok)
        (values nil err)
        (let [lua-file (filepath:gsub "%.fnl$" :.lua)]
          (M.format-lua lua-file)))))

(fn M.apply-with-chezmoi []
  "Run chezmoi apply and handle errors. Returns true or nil + error."
  (let [output (vim.fn.system "chezmoi apply 2>&1")
        exit-code vim.v.shell_error]
    (if (= exit-code 0)
        true
        ;; Put errors in quickfix list
        (do
          (var qf-entries [])
          (each [line (output:gmatch "[^\r\n]+")]
            (table.insert qf-entries {:text line}))
          (vim.fn.setqflist qf-entries :r)
          (vim.fn.setqflist [] :a {:title "chezmoi apply errors"})
          (vim.cmd.copen)
          (values nil "chezmoi apply failed! Check quickfix list.")))))

(fn M.tangle-and-apply []
  "Main workflow: tangle → compile → format → apply"
  (let [bufnr (vim.api.nvim_get_current_buf)]
    ;; Phase 1: Validation
    (let [(bufname err) (M.verify-norg-buffer bufnr)]
      (when (not bufname)
        (vim.notify err vim.log.levels.ERROR)
        (lua :return)))
    (M.save-if-modified bufnr)
    ;; Phase 2: Tangling
    (let [(tangle-path err) (M.get-tangle-metadata bufnr)]
      (when (not tangle-path)
        (vim.notify err vim.log.levels.ERROR)
        (lua :return))
      ;; Run the tangle command
      (let [(ok err) (M.tangle-current-file)]
        (when (not ok)
          (vim.notify err vim.log.levels.ERROR)
          (lua :return))
        ;; Phase 3: Compilation (if tangled to a fennel file)
        (when (and (= (type tangle-path) :string) (tangle-path:match "%.fnl$"))
          ;; Resolve relative path to absolute
          (let [bufdir (vim.fn.fnamemodify bufname ":h")
                abs-path (vim.fn.fnamemodify (.. bufdir "/" tangle-path) ":p")
                (ok err) (M.process-fennel-file abs-path)]
            (when (not ok)
              (vim.notify err vim.log.levels.ERROR)
              (lua :return))))
        ;; Return to original buffer before applying
        (vim.api.nvim_set_current_buf bufnr)
        ;; Phase 4: Application
        (let [(ok err) (M.apply-with-chezmoi)]
          (if ok
              (vim.notify "Successfully tangled and applied!"
                          vim.log.levels.INFO)
              (vim.notify err vim.log.levels.ERROR)))))))

;; Create user command
(vim.api.nvim_create_user_command :TangleAndApply M.tangle-and-apply {})

;; Create keymap (only in norg buffers)
(vim.api.nvim_create_autocmd :FileType
                             {:pattern :norg
                              :callback (fn []
                                          (vim.keymap.set :n :<leader>nA
                                                          M.tangle-and-apply
                                                          {:buffer true
                                                           :desc "Tangle and apply literate config"}))})

M