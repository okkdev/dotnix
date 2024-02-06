(local lualine (require :lualine))

(lualine.setup {:extensions [:toggleterm]
                :inactive_sections {:lualine_a [:filename]
                                    :lualine_b []
                                    :lualine_c []
                                    :lualine_x []
                                    :lualine_y []
                                    :lualine_z [:location]}
                :inactive_winbar []
                :options {:always_divide_middle true
                          :component_separators "|"
                          :section_separators {:left "" :right ""}}
                :sections {:lualine_a [{1 :mode
                                        :right_padding 2
                                        :separator {:left ""}}]
                           :lualine_b [:filename :branch]
                           :lualine_c []
                           :lualine_x []
                           :lualine_y [:filetype :progress]
                           :lualine_z [{1 :location
                                        :left_padding 2
                                        :separator {:right ""}}]}
                :tabline []})

