; Multiline f/F command
(local flash (require :flash))

(flash.setup {:modes {:search {:enabled false}}})

(vim.keymap.set [:n :x :o] :<leader>j flash.jump {:desc "flash jump"})
(vim.keymap.set [:n :x :o] :S flash.treesitter {:desc "flash treesitter"})

