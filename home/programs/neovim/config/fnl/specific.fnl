; File/Project specific settings

(local autocmd vim.api.nvim_create_autocmd)

; Note taking

(autocmd [:FileType]
         {:pattern [:markdown :norg :text]
          :callback (fn []
                      (set vim.opt_local.wrap true)
                      (vim.keymap.set [:n :x] :j :gj {:buffer true})
                      (vim.keymap.set [:n :x] :k :gk {:buffer true}))
          :desc "Enable wrapping for specific filetypes"})

; Gleam

(autocmd [:FileType] {:pattern [:gleam]
                      :callback (fn []
                                  (set vim.bo.commentstring "// %s"))
                      :desc "Gleam comment string"})

; GDScript

(when (vim.fs.root 0 :project.godot)
  (vim.fn.serverstart :/tmp/godot.socket))

