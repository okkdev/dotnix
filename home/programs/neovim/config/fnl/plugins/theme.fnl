; Styling
(let [rose-pine (require :rose-pine)]
  (rose-pine.setup {:highlight_groups {:TelescopeBorder {:bg :overlay
                                                         :fg :overlay}
                                       :TelescopeMultiSelection {:bg :highlight_high
                                                                 :fg :text}
                                       :TelescopeNormal {:bg :overlay
                                                         :fg :subtle}
                                       :TelescopePreviewTitle {:bg :iris
                                                               :fg :base}
                                       :TelescopePromptBorder {:bg :surface
                                                               :fg :surface}
                                       :TelescopePromptNormal {:bg :surface
                                                               :fg :text}
                                       :TelescopePromptTitle {:bg :pine
                                                              :fg :base}
                                       :TelescopeSelection {:bg :highlight_med
                                                            :fg :text}
                                       :TelescopeSelectionCaret {:bg :highlight_med
                                                                 :fg :love}
                                       :TelescopeTitle {:bg :love :fg :base}}}))

(let [catppuccin (require :catppuccin)]
  (catppuccin.setup {:flavour :latte
                     :background {:light :latte :dark :mocha}
                     :custom_highlights (fn [colors]
                                          {:MatchParen {:bg colors.crust}})
                     :integrations {:cmp true
                                    :gitsigns true
                                    :mini {:enabled true
                                           :indentscope_color :overlay0}
                                    :notify true
                                    :nvimtree true
                                    :treesitter true
                                    :noice true
                                    :nvimtree true
                                    :telescope {:enabled true :style :nvchad}
                                    :leap true
                                    :flash true
                                    :which_key true
                                    :lsp_trouble true}}))

; (vim.cmd.colorscheme :rose-pine)
; (vim.cmd.colorscheme :ayu)
; (vim.cmd.colorscheme :melange)
; (vim.cmd.colorscheme :oxocarbon)
(vim.cmd.colorscheme :catppuccin)

(local set_hl vim.api.nvim_set_hl)

; Customization for Pmenu
(set_hl 0 :CmpItemAbbrDeprecated {:bg :NONE :fg "#7E8294" :strikethrough true})

(set_hl 0 :CmpItemAbbrMatch {:bg :NONE :bold true :fg "#82AAFF"})
(set_hl 0 :CmpItemAbbrMatchFuzzy {:bg :NONE :bold true :fg "#82AAFF"})

(set_hl 0 :CmpItemMenu {:bg :NONE :fg "#C792EA" :italic true})

(set_hl 0 :CmpItemKindField {:bg "#B5585F" :fg "#EED8DA"})
(set_hl 0 :CmpItemKindProperty {:bg "#B5585F" :fg "#EED8DA"})
(set_hl 0 :CmpItemKindEvent {:bg "#B5585F" :fg "#EED8DA"})

(set_hl 0 :CmpItemKindText {:bg "#9FBD73" :fg "#C3E88D"})
(set_hl 0 :CmpItemKindEnum {:bg "#9FBD73" :fg "#C3E88D"})
(set_hl 0 :CmpItemKindKeyword {:bg "#9FBD73" :fg "#C3E88D"})

(set_hl 0 :CmpItemKindConstant {:bg "#D4BB6C" :fg "#FFE082"})
(set_hl 0 :CmpItemKindConstructor {:bg "#D4BB6C" :fg "#FFE082"})
(set_hl 0 :CmpItemKindReference {:bg "#D4BB6C" :fg "#FFE082"})

(set_hl 0 :CmpItemKindFunction {:bg "#A377BF" :fg "#EADFF0"})
(set_hl 0 :CmpItemKindStruct {:bg "#A377BF" :fg "#EADFF0"})
(set_hl 0 :CmpItemKindClass {:bg "#A377BF" :fg "#EADFF0"})
(set_hl 0 :CmpItemKindModule {:bg "#A377BF" :fg "#EADFF0"})
(set_hl 0 :CmpItemKindOperator {:bg "#A377BF" :fg "#EADFF0"})

(set_hl 0 :CmpItemKindVariable {:bg "#7E8294" :fg "#C5CDD9"})
(set_hl 0 :CmpItemKindFile {:bg "#7E8294" :fg "#C5CDD9"})

(set_hl 0 :CmpItemKindUnit {:bg "#D4A959" :fg "#F5EBD9"})
(set_hl 0 :CmpItemKindSnippet {:bg "#D4A959" :fg "#F5EBD9"})
(set_hl 0 :CmpItemKindFolder {:bg "#D4A959" :fg "#F5EBD9"})

(set_hl 0 :CmpItemKindMethod {:bg "#6C8ED4" :fg "#DDE5F5"})
(set_hl 0 :CmpItemKindValue {:bg "#6C8ED4" :fg "#DDE5F5"})
(set_hl 0 :CmpItemKindEnumMember {:bg "#6C8ED4" :fg "#DDE5F5"})

(set_hl 0 :CmpItemKindInterface {:bg "#58B5A8" :fg "#D8EEEB"})
(set_hl 0 :CmpItemKindColor {:bg "#58B5A8" :fg "#D8EEEB"})
(set_hl 0 :CmpItemKindTypeParameter {:bg "#58B5A8" :fg "#D8EEEB"})

