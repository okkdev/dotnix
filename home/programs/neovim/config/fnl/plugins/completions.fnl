; Completions for Path, LSP and more
(local cmp (require :cmp))
(local luasnip (require :luasnip))

(luasnip.config.setup {})

; workaround to ignore duplicate vscode snippets
(let [vscode_loader (require :luasnip.loaders.from_vscode)]
  (vscode_loader.lazy_load {:paths :$HOME/.local/share/nvim/site/pack/packer/start/friendly-snippets}))

(cmp.setup {:mapping (cmp.mapping.preset.insert {:<C-Space> (cmp.mapping.complete {})
                                                 :<C-d> (cmp.mapping.scroll_docs (- 4))
                                                 :<C-f> (cmp.mapping.scroll_docs 4)
                                                 :<CR> (cmp.mapping.confirm {:behavior cmp.ConfirmBehavior.Replace
                                                                             :select true})
                                                 :<C-e> (cmp.mapping.abort)
                                                 :<S-Tab> (cmp.mapping (fn [fallback]
                                                                         (if (cmp.visible)
                                                                             (cmp.select_prev_item)
                                                                             (luasnip.jumpable (- 1))
                                                                             (luasnip.jump (- 1))
                                                                             (fallback)))
                                                                       [:i :s])
                                                 :<Tab> (cmp.mapping (fn [fallback]
                                                                       (if (cmp.visible)
                                                                           (cmp.select_next_item)
                                                                           (luasnip.expand_or_jumpable)
                                                                           (luasnip.expand_or_jump)
                                                                           (fallback)))
                                                                     [:i :s])})
            :window {:completion {:col_offset (- 3)
                                  :side_padding 0
                                  :winhighlight "Normal:Pmenu,FloatBorder:Pmenu,Search:None"}}
            :formatting {:fields [:kind :abbr :menu]
                         :format (fn [entry vim-item]
                                   (local kind
                                          (let [lspkind (require :lspkind)
                                                cmpformat (lspkind.cmp_format {:maxwidth 50
                                                                               :mode :symbol_text})]
                                            (cmpformat entry vim-item)))
                                   (local strings
                                          (vim.split kind.kind "%s"
                                                     {:trimempty true}))
                                   (set kind.kind
                                        (.. " " (or (. strings 1) "") " "))
                                   (set kind.menu
                                        (.. "    (" (or (. strings 2) "") ")"))
                                   kind)}
            :snippet {:expand (fn [args]
                                (luasnip.lsp_expand args.body))}
            :sources [{:name :path}
                      {:name :nvim_lsp :keyword_length 1}
                      {:name :buffer :keyword_length 3}
                      {:name :luasnip :keyword_length 2}]}
           [{:name :buffer}])

; Tailwind colors in completion menu
(let [tcc (require :tailwindcss-colorizer-cmp)]
  (set cmp.config.formatting {:format tcc.formatter}))

