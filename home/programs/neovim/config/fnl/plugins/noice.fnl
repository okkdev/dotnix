; Floating UI system
(local noice (require :noice))

(noice.setup {:lsp {:override {:cmp.entry.get_documentation true
                               :vim.lsp.util.convert_input_to_markdown_lines true
                               :vim.lsp.util.stylize_markdown true}}
              :presets {:bottom_search true
                        :command_palette false
                        :long_message_to_split true
                        :lsp_doc_border false}
              :views {:cmdline_popup {:border {:padding [1 1 1 1] :style :none}
                                      :position {:col "50%" :row 5}
                                      :size {:height :auto :width 60}
                                      :filter_options {}
                                      :win_options {:winhighlight {:Normal :NormalFloat
                                                                   :FloatBorder :FloatBorder}}}
                      :popupmenu {:border {:padding [0 1 0 1] :style :none}
                                  :position {:col "50%" :row 7}
                                  :relative :editor
                                  :size {:height 10 :width 60}
                                  :win_options {:winhighlight {:FloatBorder :DiagnosticInfo
                                                               :Normal :NormalFloat}}}}
              :routes [{:filter {:event :msg_show :find :written} :view :mini}
                       {:filter {:event :msg_show
                                 :find "Already at newest change"}
                        :view :mini}
                       {:filter {:event :msg_show :find "change;"} :view :mini}
                       {:filter {:event :msg_show :find "line less;"}
                        :view :mini}
                       {:filter {:event :msg_show :find "lines less;"}
                        :view :mini}
                       {:filter {:event :msg_show :find "more line;"}
                        :view :mini}
                       {:filter {:event :msg_show :find "more lines"}
                        :view :mini}
                       {:filter {:event :msg_show :find "fewer lines"}
                        :view :mini}]})

(local notify (require :notify))

(vim.keymap.set :n :<leader>nd notify.dismiss {:desc "[d]ismiss notifications"})

(vim.keymap.set :n :<leader>na (fn [] (noice.cmd :telescope))
                {:desc "list [a]ll notifications"})

(vim.keymap.set :n :<leader>nl (fn [] (noice.cmd :last))
                {:desc "[l]ast notification"})

