; Formatter with LSP Format fallback
(local conform (require :conform))

; Disable autoformat by default
(set vim.g.disable_autoformat true)

(conform.setup {:formatters_by_ft {:css [:prettierd :rustywind_css]
                                   :d2 [:d2]
                                   :elixir [:rustywind :mix]
                                   :elm [:elm_format]
                                   :erlang [:erlfmt]
                                   :fennel [:fnlfmt]
                                   :gdscript [:gdformat]
                                   :gleam [:rustywind_gleam :gleam]
                                   :heex [:rustywind :mix]
                                   :html [:superhtml :rustywind]
                                   :javascript [:biome :rustywind]
                                   :typescript [:biome :rustywind]
                                   :nix [:nixfmt :nixpkgs_fmt]
                                   :lua [:stylua]
                                   :python [:ruff_format]
                                   :racket [:racket_fmt]
                                   :toml [:taplo]
                                   :sh [:shfmt]
                                   :sql [:sql_formatter]}
                ; :svelte {1 :rustywind :lsp-format :last}
                :default_format_opts {:lsp_format :fallback}
                ; Toggleable format on save
                :format_on_save (fn [bufnr]
                                  (let [buffer (. vim.b bufnr)]
                                    (if (or vim.g.disable_autoformat
                                            buffer.disable_autoformat)
                                        nil
                                        {:lsp_fallback true :timeout_ms 500})))
                :formatters {:rustywind_css {:command :rustywind
                                             :args [:--custom-regex
                                                    "@apply ([_a-zA\\.-Z0-9\\-:\\[\\] ]+);"
                                                    :--stdin]}
                             :rustywind_gleam {:command :rustywind
                                               :args [:--custom-regex
                                                      "class\\(\\s*\"([^\"]*)\"\\s*\\)"
                                                      :--stdin]}
                             :racket_fmt {:command :raco :args [:fmt]}}})

(let [usercmd vim.api.nvim_create_user_command]
  (usercmd :Format
           (fn [args]
             (var range nil)
             (when (not= args.count (- 1))
               (local end-line (. (vim.api.nvim_buf_get_lines 0
                                                              (- args.line2 1)
                                                              args.line2 true)
                                  1))
               (set range {:end [args.line2 (end-line:len)]
                           :start [args.line1 0]}))
             (conform.format {:async true :lsp_fallback true : range}))
           {:range true})
  (usercmd :FormatSaveDisable
           (fn [args]
             (if args.bang
                 (set vim.b.disable_autoformat true)
                 (set vim.g.disable_autoformat true)))
           {:bang true :desc "Disable autoformat-on-save"})
  (usercmd :FormatSaveEnable
           (fn [] (set vim.b.disable_autoformat false)
             (set vim.g.disable_autoformat false))
           {:desc "Enable autoformat-on-save"}))

(vim.keymap.set [:n :x] :<leader>lf :<cmd>Format<cr> {:desc :format})
