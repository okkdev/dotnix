; Multiline f/F command
(local flash (require :flash))

(flash.setup {:modes {:search {:enabled false}
                      :char {:config (fn [opts]
                                       (set opts.autohide
                                            (: (vim.fn.mode true) :find :no)))}}})

(vim.keymap.set [:n :x :o] :<leader>j flash.jump {:desc "flash jump"})
(vim.keymap.set [:n :x :o] :S flash.treesitter {:desc "flash treesitter"})
