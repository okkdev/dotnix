; Show git changes
(local gitsigns (require :gitsigns))

(gitsigns.setup {:current_line_blame true
                 :current_line_blame_opts {:virt_text_pos :right_align}})

(vim.keymap.set :n :<leader>gtd gitsigns.toggle_deleted
                {:desc "toggle git deleted"})

