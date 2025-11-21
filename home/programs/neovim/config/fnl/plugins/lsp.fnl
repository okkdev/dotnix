; LSP
(local autocmd vim.api.nvim_create_autocmd)

(autocmd :LspAttach
         {:group (vim.api.nvim_create_augroup :UserLspConfig {})
          :callback (fn [event]
                      (fn map [keys func desc]
                        (vim.keymap.set :n keys func {:buffer event.buf : desc}))

                      (map :K vim.lsp.buf.hover "hover documentation")
                      (map :gd vim.lsp.buf.definition "goto definition")
                      (map :gD vim.lsp.buf.declaration "goto declaration")
                      (map :gr vim.lsp.buf.references "goto references")
                      (map :gI vim.lsp.buf.implementation "goto implementation")
                      (map :<leader>lr vim.lsp.buf.rename :rename)
                      (map :<leader>lc vim.lsp.buf.code_action "code action")
                      (local client
                             (vim.lsp.get_client_by_id event.data.client_id))
                      (when (and client
                                 client.server_capabilities.documentHighlightProvider)
                        (autocmd [:CursorHold :CursorHoldI]
                                 {:buffer event.buf
                                  :callback vim.lsp.buf.document_highlight})
                        (autocmd [:CursorMoved :CursorMovedI]
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

(vim.keymap.set :n :<leader>lo vim.diagnostic.open_float
                {:desc "show diagnostics"})

; Helper for enabling/disabling virtual lines diagnostics
(local virtual
       {:lines {:virtual_lines {:current_line true} :virtual_text false}
        :text {:virtual_lines false :virtual_text {:current_line true}}})

(vim.keymap.set :n :<leader>ld
                (fn []
                  (if vim.b.diagnostics_open
                      (do
                        (vim.diagnostic.config virtual.text)
                        (set vim.b.diagnostics_open false))
                      (do
                        (vim.diagnostic.config virtual.lines)
                        (set vim.b.diagnostics_open true))))
                {:desc "toggle diagnostics"})

(autocmd :CursorMoved
         {:callback (fn []
                      (let [current_line (vim.fn.line ".")
                            last_line (or vim.b.last_cursor_line 0)]
                        (when (not= current_line last_line)
                          (set vim.b.last_cursor_line current_line)
                          (when vim.b.diagnostics_open
                            (vim.diagnostic.config virtual.text)
                            (set vim.b.diagnostics_open false)))))})

(vim.keymap.set :n :<leader>ln
                (fn [] (vim.diagnostic.jump {:count 1 :float false}))
                {:desc "next diagnostic"})

(vim.keymap.set :n :<leader>lp
                (fn [] (vim.diagnostic.jump {:count -1 :float false}))
                {:desc "previous diagnostic"})

; Language Servers

(local lsp vim.lsp)
(local schemastore (require :schemastore))

; Debug stuff
; (vim.lsp.set_log_level vim.lsp.log_levels.DEBUG)
; ((. (require :vim.lsp.log) :set_format_func) vim.inspect)
; (vim.lsp.set_log_level :trace)

; Simple LSP servers

(lsp.enable :bashls)
(lsp.enable :cssls)
(lsp.enable :dockerls)
(lsp.enable :elp)
(lsp.enable :fennel_ls)
(lsp.enable :gdscript)
(lsp.enable :gleam)
(lsp.enable :gopls)
(lsp.enable :nixd)
(lsp.enable :svelte)
(lsp.enable :phpactor)
(lsp.enable :ty)
(lsp.enable :pyright)
(lsp.enable :rust_analyzer)
(lsp.enable :superhtml)
(lsp.enable :ts_ls)
(lsp.enable :tombi)
(lsp.enable :uiua)
; (lsp.enable :racket_langserver)
; (lsp.enable :scheme_langserver)
; (lsp.enable :denols)

; LSP servers with configs

(lsp.enable :elixirls)
(lsp.config :elixirls {:cmd [:expert]})

(lsp.enable :biome)
(lsp.config :biome {:filetypes [:css
                                :graphql
                                :html
                                :javascript
                                :javascriptreact
                                :json
                                :jsonc
                                :typescript
                                :typescript.tsx
                                :typescriptreact
                                :vue]})

(lsp.enable :tailwindcss)
(lsp.config :tailwindcss
            {:filetypes [:astro
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

(lsp.enable :html)
(lsp.config :html {:filetypes [:templ :svg]})

(lsp.enable :jsonls)
(lsp.config :jsonls
            {:settings {:json {:schemas (schemastore.json.schemas)
                               :validate {:enable true}}}})

(lsp.enable :omnisharp)
(lsp.config :omnisharp {:cmd [:OmniSharp :settings {:useModernNet false}]})

(lsp.enable :tinymist)
(lsp.config :tinymist {:settings {:formatterMode :typstyle}})

(lsp.enable :yamlls)
(lsp.config :yamlls
            {:settings {:yaml {:schemaStore {:enable false :url ""}
                               :schemas (schemastore.yaml.schemas {:extra {:description "More permissive Compose schema"
                                                                           :fileMatch "{,docker-}compose*.{yml,yaml}"
                                                                           :name :docker-compose
                                                                           :url "https://raw.githubusercontent.com/compose-spec/compose-spec/master/schema/compose-spec.json"}})}}})
