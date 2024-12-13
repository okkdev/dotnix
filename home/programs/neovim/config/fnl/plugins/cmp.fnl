; Completions for Path, LSP and more
(local cmp (require :cmp))
(local luasnip (require :luasnip))
(local lspkind (require :lspkind))
(local tailwind_colors (require :cmp-tailwind-colors))

(luasnip.config.setup {})

(tailwind_colors.setup {:format (fn [color]
                                  {:fg color :bg nil :text "󰏘 Color"})})

(let [vscode_loader (require :luasnip.loaders.from_vscode)]
  (vscode_loader.lazy_load {}))

(cmp.setup {:mapping (cmp.mapping.preset.insert {:<C-Space> (cmp.mapping.complete {})
                                                 :<C-f> (cmp.mapping.scroll_docs (- 4))
                                                 :<C-b> (cmp.mapping.scroll_docs 4)
                                                 :<C-CR> (cmp.mapping.confirm {:select true})
                                                 :<C-e> (cmp.mapping.abort)
                                                 :<C-n> (cmp.mapping.select_next_item)
                                                 :<C-p> (cmp.mapping.select_prev_item)
                                                 :<C-l> (cmp.mapping (fn []
                                                                       (if (luasnip.expand_or_locally_jumpable)
                                                                           (luasnip.expand_or_jump))))
                                                 :<C-h> (cmp.mapping (fn []
                                                                       (if (luasnip.locally_jumpable -1)
                                                                           (luasnip.jump -1))))})
            :window {:completion {:col_offset (- 3)
                                  :side_padding 0
                                  :winhighlight "Normal:Pmenu,FloatBorder:Pmenu,Search:None"}}
            :formatting {:fields [:kind :abbr :menu]
                         :format (fn [entry vim_item]
                                   (let [cmpformat (lspkind.cmp_format {:maxwidth 50
                                                                        :mode :symbol_text
                                                                        :before tailwind_colors.format
                                                                        :symbol_map {:Copilot ""}})
                                         item (cmpformat entry vim_item)
                                         [icon typ] (vim.split item.kind "%s"
                                                               {:trimempty true})]
                                     (set item.kind (.. " " (or icon "") " "))
                                     (set item.menu (.. " (" (or typ "") ")"))
                                     item))}
            :performace {:max_view_entries 20}
            :snippet {:expand (fn [args]
                                (luasnip.lsp_expand args.body))}
            :sources [{:name :nvim_lsp}
                      {:name :luasnip}
                      {:name :copilot}
                      {:name :path}
                      {:name :buffer}]})
