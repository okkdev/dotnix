(fn on_attach [_ bufnr]
  (fn kmap [keys func desc]
    (when desc
      (var desc (.. "LSP: " desc)))
    (vim.keymap.set :n keys func {:buffer bufnr : desc}))

  (kmap :<leader>rn vim.lsp.buf.rename "[R]e[n]ame")
  (kmap :<leader>ca vim.lsp.buf.code_action "[C]ode [A]ction")
  (kmap :gd vim.lsp.buf.definition "[G]oto [D]efinition")
  (kmap :gr (. (require :telescope.builtin) :lsp_references)
        "[G]oto [R]eferences")
  (kmap :gI vim.lsp.buf.implementation "[G]oto [I]mplementation")
  (kmap :<leader>D vim.lsp.buf.type_definition "Type [D]efinition")
  (kmap :<leader>ds (. (require :telescope.builtin) :lsp_document_symbols)
        "[D]ocument [S]ymbols")
  (kmap :<leader>ws (. (require :telescope.builtin)
                       :lsp_dynamic_workspace_symbols)
        "[W]orkspace [S]ymbols")
  (kmap :K vim.lsp.buf.hover "Hover Documentation")
  (kmap :<C-k> vim.lsp.buf.signature_help "Signature Documentation")
  (kmap :gD vim.lsp.buf.declaration "[G]oto [D]eclaration")
  (kmap :<leader>wa vim.lsp.buf.add_workspace_folder "[W]orkspace [A]dd Folder")
  (kmap :<leader>wr vim.lsp.buf.remove_workspace_folder
        "[W]orkspace [R]emove Folder")
  (kmap :<leader>wl
        (fn []
          (print (vim.inspect (vim.lsp.buf.list_workspace_folders))))
        "[W]orkspace [L]ist Folders")
  (vim.api.nvim_buf_create_user_command bufnr :Format
                                        (fn [_]
                                          (vim.lsp.buf.format))
                                        {:desc "Format current buffer with LSP"}))

; Language Servers

(local lsp (require :lspconfig))
(local cmp_lsp (require :cmp_nvim_lsp))
(local capabilities
       (cmp_lsp.default_capabilities (vim.lsp.protocol.make_client_capabilities)))

(local flags {:debounce_text_changes 150})

(lsp.rust_analyzer.setup {: on_attach :settings {:rust-analyzer {}} : flags})

(lsp.elixirls.setup {:cmd [:elixir-ls] : on_attach : capabilities : flags})

(lsp.elmls.setup {: on_attach : flags})

(lsp.gleam.setup {: on_attach : flags})

;(lsp.fennel_ls.setup {: on_attach : flags})

(local cmp (require :cmp))

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

