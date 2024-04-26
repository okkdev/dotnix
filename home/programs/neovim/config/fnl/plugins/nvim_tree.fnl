; File tree view
(local nvim_tree (require :nvim-tree))
(nvim_tree.setup {:view {:side :right :width 40}
                  :update_focused_file {:enable true}
                  :git {:enable false}
                  :filters {:git_ignored false
                            :custom [:^.DS_Store$ :^.direnv$]}})

(vim.keymap.set :n :<leader>b vim.cmd.NvimTreeToggle {:desc "toggle file tree"})

