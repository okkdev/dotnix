(local cmp (require :cmp))
(local luasnip (require :luasnip))

(luasnip.config.setup {})
((. (require :luasnip.loaders.from_vscode) :lazy_load) {:paths :/Users/js/.local/share/nvim/site/pack/packer/start/friendly-snippets})

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
            :snippet {:expand (fn [args]
                                (luasnip.lsp_expand args.body))}
            :sources [{:name :path}
                      {:name :nvim_lsp :keyword_length 1}
                      {:name :buffer :keyword_length 3}
                      {:name :luasnip :keyword_length 2}]}
           [{:name :buffer}])

