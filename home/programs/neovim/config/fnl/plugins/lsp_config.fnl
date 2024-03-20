; LSP
(local aucmd vim.api.nvim_create_autocmd)

(aucmd :LspAttach
       {:callback (fn [event]
                    (fn map [keys func desc]
                      (vim.keymap.set :n keys func
                                      {:buffer event.buf
                                       :desc (.. "LSP: " desc)}))

                    (map :K vim.lsp.buf.hover "Hover Documentation")
                    (map :gd vim.lsp.buf.definition "[G]oto [D]efinition")
                    (map :gD vim.lsp.buf.declaration "[G]oto [D]eclaration")
                    (map :gr (. (require :telescope.builtin) :lsp_references)
                         "[G]oto [R]eferences")
                    (map :gI vim.lsp.buf.implementation
                         "[G]oto [I]mplementation")
                    (map :<leader>lrn vim.lsp.buf.rename "[R]e[n]ame")
                    (map :<leader>lwa vim.lsp.buf.add_workspace_folder
                         "[W]orkspace [A]dd Folder")
                    (map :<leader>lwr vim.lsp.buf.remove_workspace_folder
                         "[W]orkspace [R]emove Folder")
                    (map :<leader>lwl
                         (fn []
                           (print (vim.inspect (vim.lsp.buf.list_workspace_folders))))
                         "[W]orkspace [L]ist Folders")
                    (map :<leader>ld vim.diagnostic.open_float
                         "Show [d]iagnostics")
                    (map :<leader>lca vim.lsp.buf.code_action "[C]ode [A]ction")
                    (local client
                           (vim.lsp.get_client_by_id event.data.client_id))
                    (when (and client
                               client.server_capabilities.documentHighlightProvider)
                      (aucmd [:CursorHold :CursorHoldI]
                             {:buffer event.buf
                              :callback vim.lsp.buf.document_highlight})
                      (aucmd [:CursorMoved :CursorMovedI]
                             {:buffer event.buf
                              :callback vim.lsp.buf.clear_references})))})

; Diagnostic config

(vim.diagnostic.config {:severity_sort true
                        :update_in_insert false
                        :underline {:severity {:min vim.diagnostic.severity.INFO}}
                        :signs {:severity {:min vim.diagnostic.severity.INFO}}
                        :virtual_text {:prefix "●" :source :if_many}
                        :linehl true
                        :float {:style :minimal :source :always}})

(fn dsign [icon typ]
  (let [dtype (.. :DiagnosticSign typ)]
    (vim.fn.sign_define dtype {:text icon :texthl dtype})))

(dsign "" :Error)
(dsign "" :Warn)
(dsign "" :Info)
(dsign "" :Hint)

; Language Servers

(local lsp (require :lspconfig))
(local cmp_lsp (require :cmp_nvim_lsp))
(local capabilities
       (cmp_lsp.default_capabilities (vim.lsp.protocol.make_client_capabilities)))

(local flags {:debounce_text_changes 150})

(lsp.rust_analyzer.setup {:settings {:rust-analyzer {}} : flags})

(lsp.elixirls.setup {:cmd [:elixir-ls] : capabilities : flags})

(lsp.elmls.setup {: capabilities : flags})

(lsp.gleam.setup {: capabilities : flags})

(lsp.nil_ls.setup {: capabilities : flags})

(lsp.fennel_ls.setup {: capabilities
                      : flags
                      :settings {:fennel-ls {:extra-globals :vim}}})

(lsp.biome.setup {:single_file_support true : capabilities : flags})

(lsp.tsserver.setup {: capabilities : flags})

(lsp.tailwindcss.setup {: capabilities : flags})

(lsp.pyright.setup {: capabilities : flags})

(lsp.cssls.setup {: capabilities : flags})

(lsp.html.setup {: capabilities : flags})

(lsp.jsonls.setup {: capabilities : flags})

(lsp.gopls.setup {: capabilities : flags})

