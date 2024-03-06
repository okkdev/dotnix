; General nvim keymaps
(local map vim.keymap.set)

(set vim.g.mapleader " ")

(map [:n :x :i] :<D-s> :<cmd>w<cr> {:desc :Save})
(map [:n :x :i] :<D-z> :<cmd>undo<cr> {:desc :Undo})
(map [:n :x :i] :<D-S-z> :<cmd>redo<cr> {:desc :Redo})
(map [:n] :U :<cmd>redo<cr> {:desc :Redo})
(map [:x] :<leader>r "y:%s/<C-r>0/<C-r>0/gc<left><left><left>"
     {:desc "Replace Selection"})

(map [:n] :<Esc> :<cmd>nohlsearch<CR> {:desc "Clear search highlights"})

(map [:n :x :i] :<C-h> :<C-w>h {:desc "Focus left window"})
(map [:n :x :i] :<C-j> :<C-w>j {:desc "Focus bottom window"})
(map [:n :x :i] :<C-k> :<C-w>k {:desc "Focus top window"})
(map [:n :x :i] :<C-l> :<C-w>l {:desc "Focus right window"})

(map [:v] :J ":m '>+1<CR>gv=gv" {:desc "Move selected lines down"})
(map [:v] :K ":m '<-2<CR>gv=gv" {:desc "Move selected lines up"})
