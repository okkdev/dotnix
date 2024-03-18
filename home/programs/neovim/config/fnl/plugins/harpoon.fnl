(local harpoon (require :harpoon))

(harpoon:setup)

(vim.keymap.set :n :<leader>ha
                (fn []
                  (: (harpoon:list) :append)
                  (vim.notify (.. "Appended: " (vim.fn.expand "%")) :info
                              {:title :Harpoon}))
                {:desc "Harpoon append"})

(vim.keymap.set :n :<leader>hl
                (fn [] (harpoon.ui:toggle_quick_menu (harpoon:list)))
                {:desc "Harpoon list menu"})

(let [list (harpoon:list)]
  (vim.keymap.set :n :<C-j> (fn [] (list:select 1)))
  (vim.keymap.set :n :<C-k> (fn [] (list:select 2)))
  (vim.keymap.set :n :<C-l> (fn [] (list:select 3)))
  (vim.keymap.set :n :<C-h> (fn [] (list:select 4))))

