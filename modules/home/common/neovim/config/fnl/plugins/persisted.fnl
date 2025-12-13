(local persisted (require :persisted))
(local autocmd vim.api.nvim_create_autocmd)
(local persisted_hooks (vim.api.nvim_create_augroup :PersistedHooks {}))

(set vim.o.sessionoptions "buffers,curdir,folds,tabpages,winpos,winsize")

(persisted.setup {:autoload true :silent true :ignored_dirs ["term://"]})

(autocmd [:User]
         {:pattern :PersistedLoadPost
          :group persisted_hooks
          :callback (fn []
                      (vim.notify "Session loaded" :info {:title :Persisted}))})

(autocmd [:User]
         {:pattern :PersistedDeletePost
          :group persisted_hooks
          :callback (fn []
                      (vim.notify "Session deleted" :info {:title :Persisted}))})

; TODO: fix, doesnt work...
; Don't save no neck pain buffers
; (autocmd [:User] {:pattern :PersistedSavePre
;                   :group persisted_hooks
;                   :callback (fn []
;                               (let [nnp (require :no-neck-pain)]
;                                 (nnp.disable)))})

