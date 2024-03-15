; File tree view
(set vim.g.loaded_netrw 1)
(set vim.g.loaded_netrwPlugin 1)

(local nvim_tree (require :nvim-tree))
(nvim_tree.setup {:view {:side :right :width 40}
                  :update_focused_file {:enable true}})

(vim.keymap.set :n :<leader>b vim.cmd.NvimTreeToggle {:desc "toggle file tree"})

