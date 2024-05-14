(local persisted (require :persisted))
(local autocmd vim.api.nvim_create_autocmd)
(local persisted_hooks (vim.api.nvim_create_augroup :PersistedHooks {}))

(persisted.setup {:autoload true :silent true})

(autocmd :User {:pattern :PersistedLoadPost
                :group persisted_hooks
                :callback (fn []
                            (vim.notify "Session loaded" :info
                                        {:title :Persisted}))})

(autocmd :User {:pattern :PersistedDeletePost
                :group persisted_hooks
                :callback (fn []
                            (vim.notify "Session deleted" :info
                                        {:title :Persisted}))})

