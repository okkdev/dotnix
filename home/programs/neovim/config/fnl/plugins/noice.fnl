; Floating UI system
(local noice (require :noice))

(noice.setup {:lsp {:override {:cmp.entry.get_documentation true
                               :vim.lsp.util.convert_input_to_markdown_lines true
                               :vim.lsp.util.stylize_markdown true}}
              :presets {:bottom_search true
                        :command_palette true
                        :inc_rename false
                        :long_message_to_split true
                        :lsp_doc_border false}})

(local notify (require :notify))

(vim.keymap.set :n :<leader>nd notify.dismiss {:desc "[d]ismiss notifications"})
(vim.keymap.set :n :<leader>nl (fn [] (noice.cmd :telescope))
                {:desc "[l]ist notifications"})

