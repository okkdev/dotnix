(let [configs (require :nvim-treesitter.configs)]
  (configs.setup {:sync_install false
                  :auto_install true
                  :highlight {:enable true
                              :additional_vim_regex_highlighting false}}))

