; Autocommands
(local autocmd vim.api.nvim_create_autocmd)

(autocmd [:InsertEnter] {:callback (fn [] (set vim.o.relativenumber false))})
(autocmd [:InsertLeave] {:callback (fn [] (set vim.o.relativenumber true))})

