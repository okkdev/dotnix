(local copilot (require :copilot))
(local autocmd vim.api.nvim_create_autocmd)

(autocmd :InsertEnter {:callback (fn []
                                   (copilot.setup {:suggestion {:enabled false}
                                                   :panel {:enabled false}
                                                   :filetypes {:. false
                                                               :cvs false
                                                               :gitcommit false
                                                               :gitrebase false
                                                               :help false
                                                               :hgcommit false
                                                               :markdown true
                                                               :svn false
                                                               :yaml false}}))
                       :once true})
