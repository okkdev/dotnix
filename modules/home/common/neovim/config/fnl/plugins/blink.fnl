(local blink (require :blink.cmp))

(blink.setup {:appearance {:nerd_font_variant :mono
                           :use_nvim_cmp_as_default true
                           :kind_icons {:Class "󱡠"
                                        :Color "󰏘"
                                        :Constant "󰏿"
                                        :Constructor "󰒓"
                                        :Copilot ""
                                        :Ollama "󰳆"
                                        :Enum "󰦨"
                                        :EnumMember "󰦨"
                                        :Event "󱐋"
                                        :Field "󰜢"
                                        :File "󰈔"
                                        :Folder "󰉋"
                                        :Function "󰊕"
                                        :Interface "󱡠"
                                        :Keyword "󰻾"
                                        :Method "󰊕"
                                        :Module "󰅩"
                                        :Operator "󰪚"
                                        :Property "󰖷"
                                        :Reference "󰬲"
                                        :Snippet "󱄽"
                                        :Struct "󱡠"
                                        :Text "󰉿"
                                        :TypeParameter "󰬛"
                                        :Unit "󰪚"
                                        :Value "󰦨"
                                        :Variable "󰆦"}}
              :completion {:trigger {:prefetch_on_insert false}
                           :keyword {:range :prefix}
                           :documentation {:auto_show true
                                           :auto_show_delay_ms 0}
                           :list {:selection {:preselect true
                                              :auto_insert false}}
                           :menu {:draw {:treesitter [:lsp]
                                         :columns [[:kind_icon]
                                                   [:label :label_description]
                                                   [:kind]]
                                         :components {:label {:width {:fill true
                                                                      :max 40}}}}}
                           :ghost_text {:enabled true}}
              :keymap {:preset :default
                       :<C-CR> [(fn [cmp] (cmp.select_and_accept))]}
              :signature {:enabled true :window {:show_documentation false}}
              :cmdline {:enabled false}
              :sources {:default [:lsp :path :snippets :buffer]
                        :providers {:lsp {:opts {:tailwind_color_icon "󰏘"}}}}})
