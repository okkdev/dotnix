; General nvim keymaps
(local map vim.keymap.set)

(set vim.g.mapleader " ")
; Set maplocalleader to space for buffer-local mappings
(set vim.g.maplocalleader " ")

(map [:n] :Q :<nop> {:desc "Disable Ex mode"})
(map [:n] "q:" :<nop> {:desc "Disable command history"})

(map [:n] :<leader>k :<C-^> {:desc "Switch to last buffer"})

(map [:n :x :i] :<D-s> :<cmd>w<cr> {:desc :Save})
(map [:n :x :i] :<D-z> :<cmd>undo<cr> {:desc :Undo})
(map [:n :x :i] :<D-S-z> :<cmd>redo<cr> {:desc :Redo})
(map [:n] :U :<cmd>redo<cr> {:desc :Redo})

(map [:n] :<leader>s "?[(,]<cr>ldt,a <esc>pld/[),]<cr>F,P<esc>"
     {:desc "swap around comma"})

(map [:n :x] :s :<Nop> {:desc "Disable s binding"})

(map [:x] :<leader>p "\"_dP" {:desc "Paste without overriding the buffer"})

; Replace selection: yanks to 's' register and sets up substitution command
(map [:x] :<leader>r "\"sy:%s\\<C-r>s\\<C-r>s\\gc<left><left><left>"
     {:desc "Replace Selection"})

(map [:x] "/" "\"sy:/\\V<C-r>s<CR>N" {:desc "Search for selection"})

(map [:n] :<Esc> :<cmd>nohlsearch<CR><Esc> {:desc "Clear search highlights"})

(map [:n] "<" "<<" {:desc "simpler unindent"})
(map [:n] ">" ">>" {:desc "simpler indent"})

(map [:x] "<" :<gv {:desc "unindent without losing selection"})
(map [:x] ">" :>gv {:desc "indent without losing selection"})

; (map [:i] :<Esc> :<Esc>l
;      {:desc "exiting insert mode after 'i' wont move the cursor"})

(map :n :<C-d> :<C-d>zz {:desc "Scroll down and keep cursor in the center"})
(map :n :<C-u> :<C-u>zz {:desc "Scroll up and keep cursor in the center"})
(map :n :n :nzzzv {:desc "Find next and keep cursor in the center"})
(map :n :N :Nzzzv {:desc "Find previous and keep cursor in the center"})
