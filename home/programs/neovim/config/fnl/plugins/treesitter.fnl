(local parser_dir (.. (vim.fn.stdpath :cache) :/treesitters))
(vim.fn.mkdir parser_dir :p)
(vim.opt.runtimepath:append parser_dir)

(let [configs (require :nvim-treesitter.configs)]
  (configs.setup {:ensure_installed [:c
                                     :lua
                                     :fennel
                                     :vim
                                     :help
                                     :query
                                     :rust
                                     :elixir
                                     :heex
                                     :javascript
                                     :typescript
                                     :elm
                                     :markdown
                                     :markdown_inline
                                     :json
                                     :yaml]
                  :parser_install_dir parser_dir
                  :sync_install false
                  :auto_install true
                  :highlight {:enable true
                              :additional_vim_regex_highlighting false}}))

