(set vim.g.mapleader " ")

; (vim.keymap.set :x :<leader>p "\"_dP")

; Leap
(vim.keymap.set [:n :x :o] :<leader>f "<Plug>(leap-forward-to)"
                {:desc "leap forward to"})

(vim.keymap.set [:n :x :o] :<leader>F "<Plug>(leap-backward-to)"
                {:desc "leap backward to"})

(vim.keymap.set [:x :o] :<leader>x "<Plug>(leap-forward-till)"
                {:desc "leap forward till"})

(vim.keymap.set [:x :o] :<leader>X "<Plug>(leap-backward-till)"
                {:desc "leap backward till"})

(vim.keymap.set :n :<leader>gs "<Plug>(leap-from-window)"
                {:desc "leap from window"})

