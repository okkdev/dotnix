; LSP
(fn on_attach [_ bufnr]
  (fn kmap [keys func desc]
    (vim.keymap.set :n keys func {:buffer bufnr :desc (.. "LSP: " desc)}))

  (kmap :K vim.lsp.buf.hover "Hover Documentation")
  (kmap :gd vim.lsp.buf.definition "[G]oto [D]efinition")
  (kmap :gD vim.lsp.buf.declaration "[G]oto [D]eclaration")
  (kmap :gr (. (require :telescope.builtin) :lsp_references)
        "[G]oto [R]eferences")
  (kmap :gI vim.lsp.buf.implementation "[G]oto [I]mplementation")
  (kmap :<leader>lrn vim.lsp.buf.rename "[R]e[n]ame")
  (kmap :<leader>lwa vim.lsp.buf.add_workspace_folder
        "[W]orkspace [A]dd Folder")
  (kmap :<leader>lwr vim.lsp.buf.remove_workspace_folder
        "[W]orkspace [R]emove Folder")
  (kmap :<leader>lwl
        (fn []
          (print (vim.inspect (vim.lsp.buf.list_workspace_folders))))
        "[W]orkspace [L]ist Folders")
  (kmap :<leader>ld vim.diagnostic.open_float "Show [d]iagnostics"))

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
(local cmp (require :cmp))
(local cmp_lsp (require :cmp_nvim_lsp))
(local capabilities
       (cmp_lsp.default_capabilities (vim.lsp.protocol.make_client_capabilities)))

(local flags {:debounce_text_changes 150})

(lsp.rust_analyzer.setup {: on_attach :settings {:rust-analyzer {}} : flags})

(lsp.elixirls.setup {:cmd [:elixir-ls] : on_attach : capabilities : flags})

(lsp.elmls.setup {: on_attach : capabilities : flags})

(lsp.gleam.setup {: on_attach : capabilities : flags})

(lsp.nil_ls.setup {: on_attach : capabilities : flags})

(lsp.fennel_ls.setup {: on_attach : capabilities : flags})

(lsp.biome.setup {:single_file_support true : on_attach : capabilities : flags})

(lsp.tsserver.setup {: on_attach : capabilities : flags})

(lsp.tailwindcss.setup {: on_attach : capabilities : flags})

(lsp.pyright.setup {: on_attach : capabilities : flags})

