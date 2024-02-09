(local oil (require :oil))

(oil.setup)

(vim.keymap.set :n :<leader>o :<CMD>Oil<CR> {:desc "open [o]il"})
(vim.keymap.set :n :<leader>O "<CMD>Oil --float<CR>"
                {:desc "open [O]il floating"})

