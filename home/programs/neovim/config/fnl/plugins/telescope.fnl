; Modal thing browser
(local telescope (require :telescope))
(local builtin (require :telescope.builtin))
(local themes (require :telescope.themes))

(local find_cmd [:fd
                 :--type
                 :file
                 :--hidden
                 :--follow
                 :--color
                 :never
                 :--strip-cwd-prefix])

(telescope.setup {:extensions {:fzf {:case_mode :smart_case
                                     :fuzzy true
                                     :override_file_sorter true
                                     :override_generic_sorter true}
                               :ui-select [(themes.get_cursor {})]
                               :undo {:use_delta false}}
                  :pickers {:buffers {:sort_mru true
                                      :ignore_current_buffer true}
                            :find_files {:find_command find_cmd}}
                  :defaults {:prompt_prefix "   "
                             :selection_caret "  "
                             :entry_prefix "   "}})

(telescope.load_extension :noice)
(telescope.load_extension :fzf)
(telescope.load_extension :undo)
(telescope.load_extension :recent-files)
(telescope.load_extension :ui-select)

; Keybinds

(local map vim.keymap.set)

(map :n :<leader>ff builtin.find_files {:desc "find files"})

(map :n :<leader>fo (fn [] (builtin.oldfiles {:only_cwd true}))
     {:desc "find old files"})

(map :n :<leader>fg builtin.git_files {:desc "files git"})
(map :n :<leader>f/ telescope.extensions.live_grep_args.live_grep_args
     {:desc "search files"})

(map :n :<leader>fb builtin.buffers {:desc "find buffers"})
(map :n :<leader>fh builtin.help_tags {:desc "find help"})
(map :n :<leader>fk builtin.keymaps {:desc "find keymaps"})
(map :n :<leader>fr builtin.resume {:desc "find resume"})

(map :n :<leader><space>
     (fn []
       (telescope.extensions.recent-files.recent_files {:find_command [:fd
                                                                       :--type
                                                                       :file
                                                                       :--color
                                                                       :never]
                                                        :follow true
                                                        :hidden true
                                                        :include_current_file false}))
     {:desc "Find recent files"})

(map :n :<leader>/
     (fn []
       (builtin.current_buffer_fuzzy_find (themes.get_dropdown {:previewer false})))
     {:desc "Fuzzily search in current buffer"})

(map :n :<leader>u "<cmd>Telescope undo<cr>" {:desc "open undo history"})

