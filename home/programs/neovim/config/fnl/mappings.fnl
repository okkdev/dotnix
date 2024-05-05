; General nvim keymaps
(local map vim.keymap.set)

(set vim.g.mapleader " ")

(map [:n] :Q :<nop> {:desc "Disable Ex mode"})
(map [:n] "q:" :<nop> {:desc "Disable command history"})

(map [:n :x :i] :<D-s> :<cmd>w<cr> {:desc :Save})
(map [:n :x :i] :<D-z> :<cmd>undo<cr> {:desc :Undo})
(map [:n :x :i] :<D-S-z> :<cmd>redo<cr> {:desc :Redo})
(map [:n] :U :<cmd>redo<cr> {:desc :Redo})

(map [:n :x] :s :<Nop> {:desc "Disable s binding"})

(map [:x] :<leader>p "\"_dP" {:desc "Paste without overriding the buffer"})

(map [:x] :<leader>r "\"sy:%s$<C-r>s$<C-r>s$gc<left><left><left>"
     {:desc "Replace Selection"})

(map [:x] "/" "\"sy:/\\V<C-r>s<CR>N" {:desc "Search for selection"})

(map [:n] :<Esc> :<cmd>nohlsearch<CR> {:desc "Clear search highlights"})

; (map [:n :x :i] :<C-h> :<C-w>h {:desc "Focus left window"})
; (map [:n :x :i] :<C-j> :<C-w>j {:desc "Focus bottom window"})
; (map [:n :x :i] :<C-k> :<C-w>k {:desc "Focus top window"})
; (map [:n :x :i] :<C-l> :<C-w>l {:desc "Focus right window"})

(map [:v] :<A-j> ":m '>+1<CR>gv=gv"
     {:desc "Move selected lines down" :silent true})

(map [:v] :<A-k> ":m '<-2<CR>gv=gv"
     {:desc "Move selected lines up" :silent true})

(map :n :<C-d> :<C-d>zz {:desc "Scroll down and keep cursor in the center"})
(map :n :<C-u> :<C-u>zz {:desc "Scroll up and keep cursor in the center"})
(map :n :n :nzzzv {:desc "Find next and keep cursor in the center"})
(map :n :N :Nzzzv {:desc "Find previous and keep cursor in the center"})

