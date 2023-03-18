(local builtin (require :telescope.builtin))
(vim.keymap.set :n :<leader>pf builtin.find_files
                {:desc "[p]roject [f]ind files"})

(vim.keymap.set :n :<leader>pp builtin.git_files {:desc "[p]roject git files"})
(vim.keymap.set :n :<leader>ps builtin.live_grep
                {:desc "[p]roject [s]earch files"})

