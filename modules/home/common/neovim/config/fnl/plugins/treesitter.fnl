(let [configs (require :nvim-treesitter.config)]
  (configs.setup {:sync_install false
                  :auto_install false
                  :indent {:enable true}
                  :autotag {:enable true}
                  :highlight {:enable true
                              :additional_vim_regex_highlighting false}}))

