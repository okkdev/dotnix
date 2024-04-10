; Modal thing browser
(local telescope (require :telescope))
(local builtin (require :telescope.builtin))
(local themes (require :telescope.themes))

(local find_cmd [:fd :--hidden :--type :file :--follow :--strip-cwd-prefix])

(telescope.setup {:extensions {:fzf {:case_mode :smart_case
                                     :fuzzy true
                                     :override_file_sorter true
                                     :override_generic_sorter true}
                               :frecency {:hide_current_buffer true
                                          :workspace_scan_cmd find_cmd
                                          :default_workspace :CWD
                                          :recency-values [{:age 240
                                                            :value 10000}
                                                           {:age 1440
                                                            :value 8000}
                                                           {:age 4320
                                                            :value 6000}
                                                           {:age 10080
                                                            :value 4000}
                                                           {:age 43200
                                                            :value 2000}
                                                           {:age 129600
                                                            :value 1000}]}
                               :undo {:use_delta false}}
                  :pickers {:buffers {:sort_mru true
                                      :ignore_current_buffer true}
                            :find_files {:find_command find_cmd}}})

(telescope.load_extension :noice)
(telescope.load_extension :fzf)
(telescope.load_extension :undo)
(telescope.load_extension :frecency)

; Keybinds

(vim.keymap.set :n :<leader>ff builtin.find_files {:desc "find files"})
(vim.keymap.set :n :<leader>fo (fn [] (builtin.oldfiles {:only_cwd true}))
                {:desc "find old files"})

(vim.keymap.set :n :<leader>fg builtin.git_files {:desc "files git"})
(vim.keymap.set :n :<leader>f/
                telescope.extensions.live_grep_args.live_grep_args
                {:desc "search files"})

(vim.keymap.set :n :<leader>fb builtin.buffers {:desc "find buffers"})
(vim.keymap.set :n :<leader>fh builtin.help_tags {:desc "find help"})
(vim.keymap.set :n :<leader>fk builtin.keymaps {:desc "find keymaps"})
(vim.keymap.set :n :<leader>fr builtin.resume {:desc "find resume"})

(vim.keymap.set :n :<leader><space>
                (fn []
                  (telescope.extensions.frecency.frecency {}))
                {:desc "Find frecent files"})

(vim.keymap.set :n :<leader>/
                (fn []
                  (builtin.current_buffer_fuzzy_find (themes.get_dropdown {:previewer false})))
                {:desc "Fuzzily search in current buffer"})

(vim.keymap.set :n :<leader>u "<cmd>Telescope undo<cr>"
                {:desc "open undo history"})

