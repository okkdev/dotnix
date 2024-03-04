; Autocommands
(local autocmd vim.api.nvim_create_autocmd)

(autocmd [:InsertEnter] {:callback (fn [] (set vim.o.relativenumber false))})
(autocmd [:InsertLeave] {:callback (fn [] (set vim.o.relativenumber true))})
(autocmd [:VimEnter]
         {:command ":silent !kitty @ set-spacing padding-bottom=10"})

(autocmd [:VimLeave]
         {:command ":silent !kitty @ set-spacing padding-bottom=default"})

(autocmd [:TextYankPost]
         {:callback (fn [] (vim.highlight.on_yank))
          :desc "Highlight when yanking text"})

