; Mulitline f/F command
(local flash (require :flash))

(vim.keymap.set [:n :x :o] :<leader>f flash.jump {:desc :flash})
(vim.keymap.set [:n :x :o] :<leader>F flash.treesitter
                {:desc "flash treesitter"})

