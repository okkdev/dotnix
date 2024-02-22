; General nvim keymaps
(local map vim.keymap.set)

(set vim.g.mapleader " ")

(map [:n :x :i] :<D-s> :<cmd>w<cr> {:desc :Save})
(map [:n :x :i] :<D-z> :<cmd>undo<cr> {:desc :Undo})
(map [:n :x :i] :<D-S-z> :<cmd>redo<cr> {:desc :Redo})
(map [:n] :U :<cmd>redo<cr> {:desc :Redo})

