(let [config (require :telescope)]
  (config.setup {:extensions {:fzf {:case_mode :smart_case
                                    :fuzzy true
                                    :override_file_sorter true
                                    :override_generic_sorter true}}}))

; Keybinds

(local builtin (require :telescope.builtin))
(local themes (require :telescope.themes))

(vim.keymap.set :n :<leader>pf builtin.find_files
                {:desc "[p]roject [f]ind files"})

(vim.keymap.set :n :<leader>pp builtin.git_files {:desc "[p]roject git files"})
(vim.keymap.set :n :<leader>ps builtin.live_grep
                {:desc "[p]roject [s]earch files"})

(vim.keymap.set :n :<leader><space> builtin.buffers
                {:desc "Find existing buffers"})

(vim.keymap.set :n :<leader>/
                (fn []
                  (builtin.current_buffer_fuzzy_find (themes.get_dropdown {:previewer false
                                                                           :winblend 10})))
                {:desc "Fuzzily search in current buffer"})

