; Multiline f/F command
(local flash (require :flash))

(flash.setup)

; (vim.keymap.set [:n :x :o] :<leader>f flash.jump {:desc :flash})
(vim.keymap.set [:n :x :o] :S flash.treesitter
                {:desc "flash treesitter"})

