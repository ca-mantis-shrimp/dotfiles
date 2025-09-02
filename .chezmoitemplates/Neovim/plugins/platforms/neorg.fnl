{1 :nvim-neorg/neorg
 :opts {:load {:core.defaults {}
               :core.concealer {}
               :core.dirman {:config {:workspaces {:main "~/neorg"
                                                   :work_notes "~/dab_work_neorg_notes"
                                                   :knowledge_base "~/knowledge_base"
                                                   :config "~/.local/share/chezmoi/literate_config"
                                                   :journal "~/journal"}
                                      :autochdir true
                                      :index :index.norg
                                      :last_workspace (.. (_G.vim.fn.stdpath :cache)
                                                          :/neorg_last_workspace.txt)}}
               :core.qol.toc {}
               :core.journal {:config {:journal_folder :/years/
                                       :workspace :journal}}
               :core.esupports.metagen {:config {:type :auto}}
               :core.export {}
               :core.export.markdown {:config {:extensions :all}}
               :core.looking-glass {}
               :core.integrations.otter {}
               :core.summary {:config {:strategy (fn [files
                                                      ws-root
                                                      heading-level
                                                      include-categories]
                                                   (let [neorg (require :neorg.core)
                                                         lib neorg.lib
                                                         utils neorg.utils
                                                         modules neorg.modules
                                                         ts (modules.get_module :core.integrations.treesitter)
                                                         heading-level (or heading-level
                                                                           1)
                                                         result []
                                                         folder-structure {}
                                                         ;; Helper functions for generating output
                                                         add-heading (fn [text
                                                                          level]
                                                                       (table.insert result
                                                                                     (.. (string.rep "*"
                                                                                                     level)
                                                                                         " "
                                                                                         text)))
                                                         add-line (fn [text]
                                                                    (table.insert result
                                                                                  text))]
                                                     ;; Process files using Neorg's built-in utils.read_files
                                                     (utils.read_files files
                                                                       (fn [bufnr
                                                                            filename]
                                                                         (let [metadata (or (ts.get_document_metadata bufnr)
                                                                                            {})
                                                                               norgname (or (filename:match "(.+)%.norg$")
                                                                                            filename)
                                                                               norgname (norgname:sub (+ (length (tostring ws-root))
                                                                                                         1))
                                                                               ;; Extract folder path from file location
                                                                               path-parts (lib.tokenize_path filename)
                                                                               folder-path (if (> (length path-parts)
                                                                                                  2)
                                                                                               (table.concat (icollect [i 1 (- (length path-parts)
                                                                                                                               2)]
                                                                                                               (. path-parts
                                                                                                                  i))
                                                                                                             "/")
                                                                                               :root)
                                                                               ;; Get file metadata with fallbacks
                                                                               title (or metadata.title
                                                                                         (_G.vim.fs.basename norgname))
                                                                               categories (if (or (not metadata.categories)
                                                                                                  (= metadata.categories
                                                                                                     _G.vim.NIL))
                                                                                              [:Uncategorised]
                                                                                              (if (_G.vim.tbl_islist metadata.categories)
                                                                                                  metadata.categories
                                                                                                  [(tostring metadata.categories)]))
                                                                               description (when (not= metadata.description
                                                                                                       _G.vim.NIL)
                                                                                             metadata.description)]
                                                                           ;; Initialize folder structure if needed
                                                                           (when (not (. folder-structure
                                                                                         folder-path))
                                                                             (tset folder-structure
                                                                                   folder-path
                                                                                   {}))
                                                                           ;; Add file to each of its categories
                                                                           (each [_ category (ipairs categories)]
                                                                             (when (or (not include-categories)
                                                                                       (_G.vim.tbl_contains include-categories
                                                                                                            (category:lower)))
                                                                               (when (not (. (. folder-structure
                                                                                                folder-path)
                                                                                             category))
                                                                                 (tset (. folder-structure
                                                                                          folder-path)
                                                                                       category
                                                                                       []))
                                                                               (table.insert (. (. folder-structure
                                                                                                   folder-path)
                                                                                                category)
                                                                                             {: title
                                                                                              : norgname
                                                                                              : description}))))))
                                                     ;; Generate the final summary output
                                                     (let [sorted-folders []]
                                                       ;; Sort folders for consistent output
                                                       (each [folder _ (pairs folder-structure)]
                                                         (table.insert sorted-folders
                                                                       folder))
                                                       (table.sort sorted-folders)
                                                       ;; Create hierarchical structure: Folders → Categories → Files
                                                       (each [_ folder (ipairs sorted-folders)]
                                                         (let [folder-name (if (= folder
                                                                                  :root)
                                                                               "Root Directory"
                                                                               (lib.title (folder:gsub "/"
                                                                                                       " → ")))]
                                                           (add-heading folder-name
                                                                        heading-level)
                                                           (let [categories (. folder-structure
                                                                               folder)
                                                                 sorted-categories []]
                                                             ;; Sort categories within each folder
                                                             (each [category _ (pairs categories)]
                                                               (table.insert sorted-categories
                                                                             category))
                                                             (table.sort sorted-categories)
                                                             ;; Generate category sections with file links
                                                             (each [_ category (ipairs sorted-categories)]
                                                               (add-heading (lib.title category)
                                                                            (+ heading-level
                                                                               1))
                                                               (let [files (. categories
                                                                              category)]
                                                                 ;; Sort files by title within each category
                                                                 (table.sort files
                                                                             #(< $1.title
                                                                                 $2.title))
                                                                 (each [_ file-info (ipairs files)]
                                                                   (let [link (.. "{:$"
                                                                                  file-info.norgname
                                                                                  ":}["
                                                                                  (lib.title file-info.title)
                                                                                  "]")
                                                                         description-part (if file-info.description
                                                                                              (.. " - "
                                                                                                  file-info.description)
                                                                                              "")]
                                                                     (add-line (.. (string.rep " "
                                                                                               (+ heading-level
                                                                                                  1))
                                                                                   " - "
                                                                                   link
                                                                                   description-part))))))))))
                                                     result))}}}}
 :keys [{1 :<leader>nt
         2 "<cmd>Neorg journal today<cr>"
         :desc "Today's Journal Page"}
        {1 :<leader>nw
         2 "<cmd>Neorg workspace work_notes<cr>"
         :desc "Edit Work Notes"}
        {1 :<leader>nm
         2 "<cmd>Neorg workspace main<cr>"
         :desc "Edit Primary Notes"}
        {1 :<leader>nk
         2 "<cmd>Neorg workspace knowledge_base<cr>"
         :desc "Edit Knowledge Base"}
        {1 :<leader>nc
         2 "<cmd>Neorg workspace config<cr>"
         :desc "Edit Literate Config"}
        {1 :<localLeader>ns
         2 "<cmd>Neorg generate-workspace-summary<cr>"
         :desc "Generate Workspace Summary"}
        {1 :<leader>nr
         2 "<cmd>Neorg return<CR>"
         :desc "Return from Neorg Workspace"}
        {1 :<localLeader>nt
         2 "<cmd>Neorg tangle current-file<CR>"
         :desc "Tangle Current File"}
        {1 :<leader>ni
         2 "<cmd>Neorg index<CR>"
         :desc "Go to Index of Neorg Workspace"}]
 :dependencies [{1 :jmbuhr/otter.nvim}]
 :lazy false}

