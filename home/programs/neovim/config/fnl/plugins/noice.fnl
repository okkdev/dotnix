; Floating UI system
(local noice (require :noice))

(noice.setup {:lsp {:override {:cmp.entry.get_documentation false
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
              :routes (let [mini [:written
                                  "Already at newest change"
                                  "line less;"
                                  "lines less;"
                                  "more line"
                                  "fewer line"
                                  "lines yanked"
                                  "changes;"
                                  "change;"
                                  :>ed
                                  :<ed]
                            mini_filters (icollect [_ v (ipairs mini)]
                                           {:filter {:event :msg_show :find v}
                                            :view :mini})]
                        (vim.fn.extend [; extra filters
                                        {:filter {:event :notify
                                                  :find :Session}
                                         :view :mini}
                                        {:filter {:event :notify
                                                  :find "No information available"}
                                         :opts {:skip true}}]
                                       mini_filters))})

(local notify (require :notify))

(vim.keymap.set :n :<leader>nd notify.dismiss {:desc "dismiss notifications"})

(vim.keymap.set :n :<leader>nl (fn [] (noice.cmd :telescope))
                {:desc "list all notifications"})

(vim.keymap.set :n :<leader>nn (fn [] (noice.cmd :last))
                {:desc "last notification"})
