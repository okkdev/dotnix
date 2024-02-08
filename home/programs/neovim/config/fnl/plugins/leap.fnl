; Mulitline f/F command
(local key vim.keymap)

(key.set [:n :x :o] :<leader>f "<Plug>(leap-forward-to)"
         {:desc "leap forward to"})

(key.set [:n :x :o] :<leader>F "<Plug>(leap-backward-to)"
         {:desc "leap backward to"})

(key.set [:x :o] :<leader>x "<Plug>(leap-forward-till)"
         {:desc "leap forward till"})

(key.set [:x :o] :<leader>X "<Plug>(leap-backward-till)"
         {:desc "leap backward till"})

(key.set :n :<leader>gs "<Plug>(leap-from-window)" {:desc "leap from window"})

