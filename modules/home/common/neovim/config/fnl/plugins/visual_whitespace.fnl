(local vw (require :visual-whitespace))
(local autocmd vim.api.nvim_create_autocmd)

; run when entering visual mode
(autocmd :ModeChanged {:pattern "*:[vV\022]*"
                       :callback (fn []
                                   (vw.setup {})
                                   (let [fg (. (vim.api.nvim_get_hl 0
                                                                    {:name :NonText})
                                               :fg)
                                         bg (. (vim.api.nvim_get_hl 0
                                                                    {:name :Visual})
                                               :bg)]
                                     (vim.api.nvim_set_hl 0 :VisualNonText
                                                          {: fg : bg})))
                       :once true})
