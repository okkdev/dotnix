; LSP
(local aucmd vim.api.nvim_create_autocmd)

(aucmd :LspAttach
       {:group (vim.api.nvim_create_augroup :UserLspConfig {})
        :callback (fn [event]
                    (fn map [keys func desc]
                      (vim.keymap.set :n keys func {:buffer event.buf : desc}))

                    (map :K vim.lsp.buf.hover "hover documentation")
                    (map :gd vim.lsp.buf.definition "goto definition")
                    (map :gD vim.lsp.buf.declaration "goto declaration")
                    (map :gr (. (require :telescope.builtin) :lsp_references)
                         "goto References")
                    (map :gI vim.lsp.buf.implementation "goto implementation")
                    (map :<leader>lr vim.lsp.buf.rename :rename)
                    (map :<leader>lc vim.lsp.buf.code_action "code action")
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
                        :signs {:text {vim.diagnostic.severity.ERROR ""
                                       vim.diagnostic.severity.WARN ""
                                       vim.diagnostic.severity.INFO ""
                                       vim.diagnostic.severity.HINT ""}}
                        ; :virtual_lines {:current_line true}
                        :virtual_text {:current_line true}
                        :linehl true
                        :float {:style :minimal :source :always}})

(vim.keymap.set :n :<leader>ld vim.diagnostic.open_float
                {:desc "show diagnostics"})

(vim.keymap.set :n :<leader>ln
                (fn [] (vim.diagnostic.jump {:count 1 :float false}))
                {:desc "next diagnostic"})

(vim.keymap.set :n :<leader>lp
                (fn [] (vim.diagnostic.jump {:count -1 :float false}))
                {:desc "previous diagnostic"})

; Language Servers

(local lsp (require :lspconfig))
(local schemastore (require :schemastore))

; Can be removed when Neovim 0.11+ and Blink.cmp 0.10+
(local blink (require :blink.cmp))
(local capabilities (blink.get_lsp_capabilities))

(local flags {:debounce_text_changes 150})

; Debug stuff
; (vim.lsp.set_log_level vim.lsp.log_levels.DEBUG)
; ((. (require :vim.lsp.log) :set_format_func) vim.inspect)
; (vim.lsp.set_log_level :trace)

(lsp.rust_analyzer.setup {:settings {:rust-analyzer {}} : flags})

(lsp.elixirls.setup {:cmd [:elixir-ls] : capabilities : flags})

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
                        :filetypes [:astro
                                    :astro-markdown
                                    :clojure
                                    :eelixir
                                    :elixir
                                    :gleam
                                    :gohtml
                                    :gohtmltmpl
                                    :handlebars
                                    :html
                                    :htmlangular
                                    :html-eex
                                    :heex
                                    :markdown
                                    :mdx
                                    :php
                                    :slim
                                    :twig
                                    :css
                                    :less
                                    :postcss
                                    :sass
                                    :scss
                                    :javascript
                                    :javascriptreact
                                    :reason
                                    :rescript
                                    :typescript
                                    :typescriptreact
                                    :vue
                                    :svelte
                                    :templ]
                        :settings {:tailwindCSS {:includeLanguages {:elixir :html-eex
                                                                    :eelixir :html-eex
                                                                    :heex :html-eex
                                                                    :gleam :html}
                                                 :experimental {:classRegex ["class= \"([^\"]*)"
                                                                             "class: \"([^\"]*)"
                                                                             "class\\(\\s*\"([^\"]*)\"\\s*\\)"
                                                                             "~H\"\"\".*class=\"([^\"]*)\".*\"\"\""]}}}})

(lsp.pyright.setup {: capabilities : flags})

(lsp.cssls.setup {: capabilities : flags})

(lsp.html.setup {: capabilities : flags :filetypes [:templ :svg]})

(lsp.superhtml.setup {: capabilities : flags})

(lsp.jsonls.setup {: capabilities
                   : flags
                   :settings {:json {:schemas (schemastore.json.schemas)
                                     :validate {:enable true}}}})

(lsp.gopls.setup {: capabilities : flags})

(lsp.gdscript.setup {: capabilities : flags})

(lsp.phpactor.setup {: capabilities : flags})

(lsp.bashls.setup {: capabilities : flags})

(lsp.dartls.setup {: capabilities : flags})

(lsp.dockerls.setup {: capabilities : flags})

(lsp.elp.setup {: capabilities : flags})

(lsp.uiua.setup {: capabilities : flags})

(lsp.omnisharp.setup {:cmd [:OmniSharp]
                      :settings {:useModernNet false}
                      : capabilities
                      : flags})

(lsp.tinymist.setup {: capabilities
                     : flags
                     :settings {:formatterMode :typstyle}})

(lsp.yamlls.setup {: capabilities
                   : flags
                   :settings {:yaml {:schemaStore {:enable false :url ""}
                                     :schemas (schemastore.yaml.schemas {:extra {:description "More permissive Compose schema"
                                                                                 :fileMatch "{,docker-}compose*.{yml,yaml}"
                                                                                 :name :docker-compose
                                                                                 :url "https://raw.githubusercontent.com/compose-spec/compose-spec/master/schema/compose-spec.json"}})}}})
