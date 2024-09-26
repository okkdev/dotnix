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

(when (vim.loop.fs_stat (.. (vim.fn.getcwd) :/project.godot))
  (vim.fn.serverstart :./godot.sock))

; Dockerfiles

(autocmd [:BufRead :BufNewFile]
         {:pattern :Dockerfile*
          :command "set filetype=dockerfile"
          :desc "Set filetype for Dockerfiles"})

