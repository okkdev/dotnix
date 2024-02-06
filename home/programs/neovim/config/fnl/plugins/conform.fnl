(local conform (require :conform))

(conform.setup {:formatters_by_ft {:css [:rustywind]
                                   :elixir [:mix]
                                   :elm [:elm_format]
                                   :fennel [:fnlfmt]
                                   :heex [:rustywind]
                                   :html [:rustywind]
                                   :nix [:nixfmt]}
                :format_on_save (fn [bufnr]
                                  (let [buffer (. vim.b bufnr)]
                                    (if (or vim.g.disable_autoformat
                                            buffer.disable_autoformat)
                                        nil
                                        {:lsp_fallback true :timeout_ms 500})))})

(vim.api.nvim_create_user_command :Format
                                  (fn [args]
                                    (var range nil)
                                    (when (not= args.count (- 1))
                                      (local end-line
                                             (. (vim.api.nvim_buf_get_lines 0
                                                                            (- args.line2
                                                                               1)
                                                                            args.line2
                                                                            true)
                                                1))
                                      (set range
                                           {:end [args.line2 (end-line:len)]
                                            :start [args.line1 0]}))
                                    (conform.format {:async true
                                                     :lsp_fallback true
                                                     : range}))
                                  {:range true})

(vim.api.nvim_create_user_command :FormatSaveDisable
                                  (fn [args]
                                    (if args.bang
                                        (set vim.b.disable_autoformat true)
                                        (set vim.g.disable_autoformat true)))
                                  {:bang true
                                   :desc "Disable autoformat-on-save"})

(vim.api.nvim_create_user_command :FormatSaveEnable
                                  (fn [] (set vim.b.disable_autoformat false)
                                    (set vim.g.disable_autoformat false))
                                  {:desc "Enable autoformat-on-save"})

(vim.keymap.set [:n :x] :<leader>lf "<cmd>:Format<cr>" {:desc :format})

