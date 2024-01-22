(set vim.o.timeout true)
(set vim.o.timeoutlen 300)

(let [config (require :which-key)]
  (config.setup {:icons {:breadcrumb "»" :separator "->" :group "+"}
                 :popup_mappings {:scroll_down :<c-d> :scroll_up :<c-u>}
                 :hidden [:<silent> :<cmd> :<Cmd> :<CR> :call :lua "^:" "^ "]
                 :height {:min 0 :max 6}
                 :align :center}))

