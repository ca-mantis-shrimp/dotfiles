(local M {})

(fn M.find-chezmoi-root []
  "Find the chezmoi source directory by looking for .chezmoi* files"
  (let [current-dir (vim.fn.getcwd)
        markers [:.chezmoiignore :.chezmoitemplates]
        search-path (vim.fs.find markers
                                 {:upward true :path current-dir :type :file})]
    (if (and search-path (> (length search-path) 0))
        (vim.fn.fnamemodify (. search-path 1) ":h")
        (do
          (vim.notify "Could not find chezmoi root directory"
                      vim.log.levels.WARN)
          nil))))

(fn M.get-tangle-path [norg-file]
  "Extract tangle directive from .norg file metadata. Returns path or nil."
  (let [lines (vim.fn.readfile norg-file)]
    (var in-metadata false)
    (var tangle-path nil)
    (each [_ line (ipairs lines)]
      (when (line:match "^@document.meta")
        (set in-metadata true))
      (when (and in-metadata (line:match "^tangle:"))
        (set tangle-path (line:match "^tangle:%s*(.+)$")))
      (when (line:match "^@end")
        (set in-metadata false)))
    tangle-path))

(fn M.resolve-tangle-path [norg-file tangle-directive]
  "Convert relative tangle path to absolute path"
  (let [norg-dir (vim.fn.fnamemodify norg-file ":h")
        combined (.. norg-dir "/" tangle-directive)]
    (vim.fn.fnamemodify combined ":p")))

(fn M.chezmoi-source-to-dest [source-path]
  "Convert chezmoi source path to destination path. Returns nil if not a chezmoi file."
  (let [home (os.getenv :HOME)
        patterns [;; dot_ becomes .
                  ["^.*/dot_(.+)%.tmpl$" (.. home "/%1")]
                  ["^.*/dot_(.+)$" (.. home "/.%1")]
                  ;; remove_ gets stripped
                  ["^.*/dot_config/remove_(.+)%.tmpl$" (.. home "/.config/%1")]
                  ["^.*/dot_config/remove_(.+)$" (.. home "/.config/%1")]
                  ;; AppData for Windows (less common in this context)
                  ["^.*/AppData/Local/remove_(.+)%.tmpl$"
                   (.. home "/AppData/Local/%1")]
                  ["^.*/AppData/Local/remove_(.+)$"
                   (.. home "/AppData/Local/%1")]
                  ;; Direct .config paths
                  ["^.*/dot_config/(.+)%.tmpl$" (.. home "/.config/%1")]
                  ["^.*/dot_config/(.+)$" (.. home "/.config/%1")]]]
    (var result nil)
    (each [_ [pattern replacement] (ipairs patterns)]
      (when (not result)
        (let [transformed (source-path:gsub pattern replacement)]
          (when (not= transformed source-path)
            (set result transformed)))))
    result))

(fn M.resolve-template-reference [tmpl-file]
  "If file is a template reference, return the template path. Otherwise nil."
  (when (vim.fn.filereadable tmpl-file)
    (let [content (table.concat (vim.fn.readfile tmpl-file) "\n")
          pattern (.. "{{" "%-" "%s*template%s+" "\\\"([^\\\"]+)\\\"" "%s+%."
                      "%s*%-" "}}")
          template-match (content:match pattern)]
      (when template-match
        (let [root (M.find-chezmoi-root)]
          (when root
            (.. root :/.chezmoitemplates/ template-match)))))))

(fn M.trace-pipeline [norg-file]
  "Trace the full pipeline from .norg file to destination(s). Returns a table describing the path."
  (let [result {:source norg-file :steps []}
        tangle-directive (M.get-tangle-path norg-file)]
    (if (not tangle-directive)
        (do
          (set result.error "No tangle directive found")
          result)
        (do
          (var tangle-path (M.resolve-tangle-path norg-file tangle-directive))
          (table.insert result.steps {:stage :tangle :file tangle-path})
          ;; If it's a fennel file, there will be a compiled lua file
          (when (tangle-path:match "%.fnl$")
            (let [lua-path (tangle-path:gsub "%.fnl$" :.lua)]
              (table.insert result.steps {:stage :compile :file lua-path})
              (set tangle-path lua-path)))
          ;; Now we need to find which chezmoi source file references this template
          (let [root (M.find-chezmoi-root)
                template-name (tangle-path:match ".*/%.chezmoitemplates/(.+)$")]
            (when (and root template-name)
              ;; Search for .tmpl files that reference this template
              (let [search-cmd (.. "grep -r '\"" template-name "\"' " root
                                   "/dot_config " root "/AppData "
                                   "2>/dev/null | cut -d: -f1")
                    tmpl-files (vim.fn.systemlist search-cmd)]
                (each [_ tmpl-file (ipairs tmpl-files)]
                  (let [dest (M.chezmoi-source-to-dest tmpl-file)]
                    (when dest
                      (table.insert result.steps
                                    {:stage :template-ref :source tmpl-file})
                      (table.insert result.steps
                                    {:stage :destination :file dest})))))))
          result))))

(fn M.show-current-pipeline []
  "Show the pipeline for the current .norg file"
  (let [current-file (vim.api.nvim_buf_get_name 0)]
    (if (not (current-file:match "%.norg$"))
        (vim.notify "Not a .norg file" vim.log.levels.WARN)
        (let [pipeline (M.trace-pipeline current-file)
              lines [(.. "Pipeline for: " pipeline.source) ""]]
          (if pipeline.error
              (table.insert lines (.. "Error: " pipeline.error))
              (each [_ step (ipairs pipeline.steps)]
                (let [stage-name (: step.stage :gsub "-" " ")]
                  (table.insert lines
                                (.. "  [" stage-name "] → "
                                    (or step.file step.source))))))
          ;; Show in a floating window
          (let [buf (vim.api.nvim_create_buf false true)
                width 100
                height (+ (length lines) 2)
                row (math.floor (/ (- vim.o.lines height) 2))
                col (math.floor (/ (- vim.o.columns width) 2))
                opts {:relative :editor
                      : width
                      : height
                      : row
                      : col
                      :style :minimal
                      :border :rounded
                      :title " Literate Config Pipeline "
                      :title_pos :center}]
            (vim.api.nvim_buf_set_lines buf 0 -1 false lines)
            (vim.api.nvim_open_win buf true opts)
            (vim.api.nvim_buf_set_option buf :modifiable false)
            (vim.keymap.set :n :q :<cmd>close<cr> {:buffer buf}))))))

(vim.api.nvim_create_user_command :InspectPipeline M.show-current-pipeline {})

(vim.api.nvim_create_autocmd :FileType
                             {:pattern :norg
                              :callback (fn []
                                          (vim.keymap.set :n :<leader>ni
                                                          M.show-current-pipeline
                                                          {:buffer true
                                                           :desc "Inspect literate config pipeline"}))})

M

