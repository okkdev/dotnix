(fn on_attach [_ bufnr]
  (fn kmap [keys func desc]
    (when desc
      (var desc (.. "LSP: " desc)))
    (vim.keymap.set :n keys func {:buffer bufnr : desc}))

  (kmap :K vim.lsp.buf.hover "Hover Documentation")
  (kmap :gd vim.lsp.buf.definition "[G]oto [D]efinition")
  (kmap :gD vim.lsp.buf.declaration "[G]oto [D]eclaration")
  (kmap :gr (. (require :telescope.builtin) :lsp_references)
        "[G]oto [R]eferences")
  (kmap :gI vim.lsp.buf.implementation "[G]oto [I]mplementation")
  (kmap :<leader>lrn vim.lsp.buf.rename "[R]e[n]ame")
  (kmap :<leader>lca vim.lsp.buf.code_action "[C]ode [A]ction")
  (kmap :<leader>ld vim.lsp.buf.type_definition "Type [D]efinition")
  (kmap :<leader>lds (. (require :telescope.builtin) :lsp_document_symbols)
        "[D]ocument [S]ymbols")
  (kmap :<leader>lwa vim.lsp.buf.add_workspace_folder "[W]orkspace [A]dd Folder")
  (kmap :<leader>lwr vim.lsp.buf.remove_workspace_folder
        "[W]orkspace [R]emove Folder")
  (kmap :<leader>lwl
        (fn []
          (print (vim.inspect (vim.lsp.buf.list_workspace_folders))))
        "[W]orkspace [L]ist Folders"))

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

(lsp.nixd.setup {: on_attach : capabilities : flags})

(lsp.fennel_ls.setup {: on_attach : capabilities : flags})

(lsp.biome.setup {:cmd [:biome
                        :lsp-proxy
                        :--config-path
                        :$HOME/.config/biome/biome.json]
                  :single_file_support true
                  : on_attach
                  : capabilities
                  : flags})

; cmdline search
(cmp.setup.cmdline "/" {:mapping (cmp.mapping.preset.cmdline)
                        :sources [{:name :buffer}]})

; cmdline command
(cmp.setup.cmdline ":"
                   {:mapping (cmp.mapping.preset.cmdline)
                    :sources (cmp.config.sources [{:name :path}]
                                                 [{:name :cmdline
                                                   :option {:ignore_cmds [:Man
                                                                          "!"]}}])})

