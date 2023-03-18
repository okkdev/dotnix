(local opts {:noremap true :silent true})
(vim.keymap.set :n :<space>e vim.diagnostic.open_float opts)
(vim.keymap.set :n "[d" vim.diagnostic.goto_prev opts)
(vim.keymap.set :n "]d" vim.diagnostic.goto_next opts)
(vim.keymap.set :n :<space>q vim.diagnostic.setloclist opts)

(fn on-attach [client bufnr]
  (vim.api.nvim_buf_set_option bufnr :omnifunc "v:lua.vim.lsp.omnifunc")
  (local bufopts {:buffer bufnr :noremap true :silent true})
  (vim.keymap.set :n :gD vim.lsp.buf.declaration bufopts)
  (vim.keymap.set :n :gd vim.lsp.buf.definition bufopts)
  (vim.keymap.set :n :K vim.lsp.buf.hover bufopts)
  (vim.keymap.set :n :gi vim.lsp.buf.implementation bufopts)
  (vim.keymap.set :n :<C-k> vim.lsp.buf.signature_help bufopts)
  (vim.keymap.set :n :<space>wa vim.lsp.buf.add_workspace_folder bufopts)
  (vim.keymap.set :n :<space>wr vim.lsp.buf.remove_workspace_folder bufopts)
  (vim.keymap.set :n :<space>wl
                  (fn []
                    (print (vim.inspect (vim.lsp.buf.list_workspace_folders))))
                  bufopts)
  (vim.keymap.set :n :<space>D vim.lsp.buf.type_definition bufopts)
  (vim.keymap.set :n :<space>rn vim.lsp.buf.rename bufopts)
  (vim.keymap.set :n :<space>ca vim.lsp.buf.code_action bufopts)
  (vim.keymap.set :n :gr vim.lsp.buf.references bufopts)
  (vim.keymap.set :n :<space>f
                  (fn []
                    (vim.lsp.buf.format {:async true}))
                  bufopts))

(local lsp-flags {:debounce_text_changes 150})
(let [lsp (. (require :lspconfig) :rust_analyzer)]
  (lsp.setup {:flags lsp-flags
              :on_attach on-attach
              :settings {:rust-analyzer {}}}))

