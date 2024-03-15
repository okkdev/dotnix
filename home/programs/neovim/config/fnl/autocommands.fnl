; Autocommands
(local autocmd vim.api.nvim_create_autocmd)

(autocmd [:InsertEnter] {:callback (fn [] (set vim.o.relativenumber false))})
(autocmd [:InsertLeave] {:callback (fn [] (set vim.o.relativenumber true))})

(autocmd [:UIEnter] {:command ":silent !kitty @ set-spacing padding-bottom=10"})

(autocmd [:VimLeavePre]
         {:command ":silent !kitty @ set-spacing padding-bottom=default"})

(autocmd [:TextYankPost]
         {:callback (fn [] (vim.highlight.on_yank))
          :desc "Highlight when yanking text"})

; (autocmd [:Colorscheme :UIEnter]
;          {:callback (fn []
;                       (local bg (. (vim.api.nvim_get_hl_by_name :Normal true)
;                                    :background))
;                       (local bghex (string.format "#%06x" bg))
;                       (os.execute (.. "kitty @ set-colors -c background=\"" bghex
;                                       "\"")))})
; (autocmd [:VimLeavePre]
;          {:command ":silent !kitty @ set-colors --reset"})
;
