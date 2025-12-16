; Styling
(local colorscheme vim.cmd.colorscheme)
(local usercmd vim.api.nvim_create_user_command)

; ; This shouldn't be necessary, but seems like nvim 0.10 doesn't detect background color correct/fast enough...
; (if (= (os.execute "defaults read -g AppleInterfaceStyle > /dev/null 2> /dev/null")
;        0)
;     (set vim.o.background :dark)
;     (set vim.o.background :light))

(local current_theme :zenbones)

(usercmd :DarkTheme (fn []
                      (set vim.o.background :dark)
                      (colorscheme vim.g.colors_name))
         {:desc "Sets dark theme"})

(usercmd :LightTheme (fn []
                       (set vim.o.background :light)
                       (colorscheme vim.g.colors_name))
         {:desc "Sets light theme"})

; devicon settings
(let [icons (require :nvim-web-devicons)]
  (icons.setup {:override {:gleam {:icon ""
                                   :color "#ffaff3"
                                   :cterm_color :219
                                   :name :Gleam}}}))

; Theme settings

(let [rose-pine (require :rose-pine)]
  (rose-pine.setup {:highlight_groups {:MatchParen {:bg :subtle}
                                       :MiniStatuslineFilename {:fg :muted
                                                                :bg :base}
                                       :StatusLine {:bg :base}
                                       :StatusLineNC {:bg :base}
                                       :BlinkCmpDoc {:bg :surface}
                                       :BlinkCmpDocSeparator {:bg :surface}
                                       :BlinkCmpDocBorder {:bg :surface}}}))

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
                                    :leap true
                                    :flash true
                                    :which_key true}}))

(let [everforest (require :everforest)]
  (everforest.setup {:background :hard
                     :on_highlights (fn [hl p]
                                      (set hl.StatusLineNC {:bg p.bg0})
                                      (set hl.StatusLine {:bg p.bg0}))}))

; Activate the initial theme
(colorscheme current_theme)
