; Modal thing browser
(local telescope (require :telescope))
(local builtin (require :telescope.builtin))
(local themes (require :telescope.themes))

(telescope.setup {:extensions {:fzf {:case_mode :smart_case
                                     :fuzzy true
                                     :override_file_sorter true
                                     :override_generic_sorter true}
                               :undo {:use_delta true}}
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

; Keybinds

(vim.keymap.set :n :<leader>pp builtin.find_files {:desc "[p]roject files"})

(vim.keymap.set :n :<leader>pg builtin.git_files
                {:desc "[p]roject [g]it files"})

(vim.keymap.set :n :<leader>p/ builtin.live_grep
                {:desc "[p]roject search files"})

(vim.keymap.set :n :<leader><space> builtin.buffers
                {:desc "Find existing buffers"})

(vim.keymap.set :n :<leader>/
                (fn []
                  (builtin.current_buffer_fuzzy_find (themes.get_dropdown {:previewer false
                                                                           :winblend 10})))
                {:desc "Fuzzily search in current buffer"})

(vim.keymap.set :n :<leader>u "<cmd>Telescope undo<cr>"
                {:desc "open [u]ndo history"})

