; Modal thing browser
(local telescope (require :telescope))
(local builtin (require :telescope.builtin))
(local themes (require :telescope.themes))

(telescope.setup {:extensions {:fzf {:case_mode :smart_case
                                     :fuzzy true
                                     :override_file_sorter true
                                     :override_generic_sorter true}
                               :undo {:use_delta false}}
                  :pickers {:buffers {:sort_mru true
                                      :ignore_current_buffer true}
                            :find_files {:find_command [:fd
                                                        :--hidden
                                                        :--type
                                                        :file
                                                        :--follow
                                                        :--strip-cwd-prefix]}}})

(telescope.load_extension :noice)
(telescope.load_extension :fzf)
(telescope.load_extension :undo)
(telescope.load_extension :frecency)

; Keybinds

(vim.keymap.set :n :<leader>ff builtin.find_files {:desc "[f]ind [f]iles"})
(vim.keymap.set :n :<leader>fg builtin.git_files {:desc "[f]iles [g]it"})
(vim.keymap.set :n :<leader>f/
                telescope.extensions.live_grep_args.live_grep_args
                {:desc "search [f]iles"})
(vim.keymap.set :n :<leader>fb builtin.buffers {:desc "[f]ind [b]uffers"})
(vim.keymap.set :n :<leader>fh builtin.help_tags {:desc "[f]ind [h]elp"})
(vim.keymap.set :n :<leader>fk builtin.keymaps {:desc "[f]ind [k]eymaps"})
(vim.keymap.set :n :<leader>fr builtin.resume {:desc "[f]ind [r]esume"})

(vim.keymap.set :n :<leader><space> "<Cmd>Telescope frecency workspace=CWD<CR>"
                {:desc "Find frecent files"})

(vim.keymap.set :n :<leader>/
                (fn []
                  (builtin.current_buffer_fuzzy_find (themes.get_dropdown {:previewer false})))
                {:desc "Fuzzily search in current buffer"})

(vim.keymap.set :n :<leader>u "<cmd>Telescope undo<cr>"
                {:desc "open [u]ndo history"})

