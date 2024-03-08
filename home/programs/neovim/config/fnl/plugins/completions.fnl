; Completions for Path, LSP and more
(local cmp (require :cmp))
(local luasnip (require :luasnip))
(local lspkind (require :lspkind))
(local tailwind_colors (require :cmp-tailwind-colors))

(luasnip.config.setup {})

(tailwind_colors.setup {:format (fn [color]
                                  {:fg color :bg nil :text "󰏘 Color"})})

(let [vscode_loader (require :luasnip.loaders.from_vscode)]
  (vscode_loader.lazy_load))

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
                         :format (let [cmpformat (lspkind.cmp_format {:maxwidth 50
                                                                      :mode :symbol_text
                                                                      :before tailwind_colors.format})]
                                   (fn [entry vim_item]
                                     (let [item (cmpformat entry vim_item)
                                           [icon typ] (vim.split item.kind "%s"
                                                                 {:trimempty true})]
                                       (set item.kind (.. " " (or icon "") " "))
                                       (set item.menu (.. " (" (or typ "") ")"))
                                       item)))}
            :snippet {:expand (fn [args]
                                (luasnip.lsp_expand args.body))}
            :sources [{:name :path}
                      {:name :nvim_lsp :keyword_length 1}
                      {:name :buffer :keyword_length 3}
                      {:name :luasnip :keyword_length 2}]}
           [{:name :buffer}])

