(local blink (require :blink.cmp))

(blink.setup {:appearance {:nerd_font_variant :mono
                           :use_nvim_cmp_as_default true
                           :kind_icons {:Class "󱡠"
                                        :Color "󰏘"
                                        :Constant "󰏿"
                                        :Constructor "󰒓"
                                        :Copilot ""
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
              :completion {:keyword {:range :prefix}
                           :documentation {:auto_show true
                                           :auto_show_delay_ms 0}
                           :list {:selection {:preselect true
                                              :auto_insert false}}
                           :menu {:draw {:treesitter [:lsp :copilot]
                                         :columns [[:kind_icon]
                                                   [:label :label_description]
                                                   [:kind]]
                                         :components {:label {:width {:fill true
                                                                      :max 40}}}}}
                           :ghost_text {:enabled true}}
              :keymap {:preset :default
                       :<C-CR> [(fn [cmp] (cmp.select_and_accept))]}
              :signature {:enabled true
                          ;wait for 0.11
                          ;:window {:show_documentation false}
                          }
              :cmdline {:sources {}}
              :sources {:default [:lsp :path :snippets :buffer :copilot]
                        :providers {:lsp {:opts {:tailwind_color_icon "󰏘"}}
                                    :copilot {:async true
                                              :module :blink-cmp-copilot
                                              :name :copilot
                                              :score_offset 0
                                              :transform_items (fn [_ items]
                                                                 (let [blink_types (require :blink.cmp.types)
                                                                       item_kind blink_types.CompletionItemKind
                                                                       kind_idx (+ (length item_kind)
                                                                                   1)]
                                                                   (tset item_kind
                                                                         kind_idx
                                                                         :Copilot)
                                                                   (icollect [_ item (ipairs items)]
                                                                     (do
                                                                       (set item.kind
                                                                            kind_idx)
                                                                       item))))}}}})
