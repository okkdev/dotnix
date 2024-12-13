; LSP
(local aucmd vim.api.nvim_create_autocmd)

(aucmd :LspAttach
       {:group (vim.api.nvim_create_augroup :UserLspConfig {})
        :callback (fn [event]
                    (fn map [keys func desc]
                      (vim.keymap.set :n keys func
                                      {:buffer event.buf
                                       :desc (.. "LSP: " desc)}))

                    (map :K vim.lsp.buf.hover "Hover Documentation")
                    (map :gd vim.lsp.buf.definition "Goto Definition")
                    (map :gD vim.lsp.buf.declaration "Goto Declaration")
                    (map :gr (. (require :telescope.builtin) :lsp_references)
                         "Goto References")
                    (map :gI vim.lsp.buf.implementation "Goto Implementation")
                    (map :<leader>lrn vim.lsp.buf.rename :Rename)
                    (map :<leader>lwa vim.lsp.buf.add_workspace_folder
                         "Workspace Add Folder")
                    (map :<leader>lwr vim.lsp.buf.remove_workspace_folder
                         "Workspace Remove Folder")
                    (map :<leader>lwl
                         (fn []
                           (print (vim.inspect (vim.lsp.buf.list_workspace_folders))))
                         "Workspace List Folders")
                    (map :<leader>lca vim.lsp.buf.code_action "Code Action")
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

(vim.keymap.set :n :<leader>ld vim.diagnostic.open_float
                {:desc "Show diagnostics"})

(vim.keymap.set :n "]d" vim.diagnostic.goto_next {:desc "Goto next diagnostic"})
(vim.keymap.set :n "[d" vim.diagnostic.goto_prev
                {:desc "Goto previous diagnostic"})

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
       (let [nvim_capabilities (vim.lsp.protocol.make_client_capabilities)
             cmp_capabilities (cmp_lsp.default_capabilities)]
         (vim.tbl_deep_extend :force nvim_capabilities cmp_capabilities)))

(local flags {:debounce_text_changes 150})

; Debug stuff
; (vim.lsp.set_log_level vim.lsp.log_levels.DEBUG)
; ((. (require :vim.lsp.log) :set_format_func) vim.inspect)
; (vim.lsp.set_log_level :trace)

(lsp.rust_analyzer.setup {:settings {:rust-analyzer {}} : flags})

(lsp.elixirls.setup {:cmd [:elixir-ls] : capabilities : flags})
; (lsp.lexical.setup {:cmd [:lexical] : capabilities : flags})

(lsp.elmls.setup {: capabilities : flags})

(lsp.gleam.setup {: capabilities : flags})

(lsp.nil_ls.setup {: capabilities : flags})

(lsp.fennel_ls.setup {: capabilities
                      : flags
                      :settings {:fennel-ls {:extra-globals :vim}}})

(lsp.biome.setup {:single_file_support true : capabilities : flags})
(lsp.ts_ls.setup {: capabilities : flags})
;(lsp.denols.setup {: capabilities : flags})

;(lsp.tailwindcss.setup {: capabilities
;                        : flags
;                        :on_attach (fn [client _buffer]
;                                     (set client.server_capabilities.hoverProvider
;                                          false))})
(lsp.tailwindcss.setup {: capabilities
                        : flags
                        :settings {:tailwindCSS {:includeLanguages {:elixir :html-eex
                                                                    :eelixir :html-eex
                                                                    :heex :html-eex}
                                                 :experimental {:classRegex ["class= \"([^\"]*)"
                                                                             "class: \"([^\"]*)"
                                                                             "~H\"\"\".*class=\"([^\"]*)\".*\"\"\""]}}}})

(lsp.pyright.setup {: capabilities : flags})

(lsp.cssls.setup {: capabilities : flags})

(lsp.html.setup {: capabilities : flags :filetypes [:templ :svg]})

(lsp.superhtml.setup {: capabilities : flags})

(lsp.jsonls.setup {: capabilities : flags})

(lsp.gopls.setup {: capabilities : flags})

(lsp.gdscript.setup {: capabilities : flags})

(lsp.phpactor.setup {: capabilities : flags})

(lsp.bashls.setup {: capabilities : flags})

(lsp.dartls.setup {: capabilities : flags})

(lsp.dockerls.setup {: capabilities : flags})

(lsp.elp.setup {: capabilities : flags})

(lsp.uiua.setup {: capabilities : flags})

(lsp.tinymist.setup {: capabilities
                     : flags
                     :settings {:formatterMode :typstyle}})

(lsp.yamlls.setup {: capabilities
                   : flags
                   :settings {:yaml {:schemas {"https://json.schemastore.org/github-workflow.json" :/.github/workflows/*
                                               "https://json.schemastore.org/github-action.json" "/.github/action.{yaml,yml}"
                                               "https://gitlab.com/gitlab-org/gitlab/-/raw/master/app/assets/javascripts/editor/schema/ci.json" :.gitlab-ci.yml
                                               "https://raw.githubusercontent.com/compose-spec/compose-spec/master/schema/compose-spec.json" "docker-compose*.{yml,yaml}"}}}})
