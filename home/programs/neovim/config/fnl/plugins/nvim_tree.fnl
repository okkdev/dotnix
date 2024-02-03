(set vim.g.loaded_netrw 1)
(set vim.g.loaded_netrwPlugin 1)

(local nvim_tree (require :nvim-tree))
(nvim_tree.setup {:view {:side :right}})

(vim.keymap.set :n :<leader>b vim.cmd.NvimTreeToggle {:desc "toggle file tree"})
