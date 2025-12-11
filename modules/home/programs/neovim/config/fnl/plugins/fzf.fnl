(local fzf (require :fzf-lua))

(fzf.setup {:winopts {:backdrop 95
                      :border [" " " " " " " " " " " " " " " "]
                      :preview {:border :noborder}}
            :fzf_opts {:--layout :default :--separator " " :--gutter " "}
            :fzf_colors true})

(local map vim.keymap.set)

(map :n :<leader>ff fzf.files {:desc "find files"})
(map :n :<leader>fg fzf.git_files {:desc "files git"})
(map :n :<leader>f/ fzf.live_grep {:desc "search files"})
(map :n :<leader>/ fzf.blines {:desc "Fuzzily search lines in current buffer"})
(map :n :<leader>fb fzf.buffers {:desc "find buffers"})
(map :n :<leader>fd fzf.diagnostics_workspace {:desc "find diagnostics"})
(map :n :<leader>fh fzf.helptags {:desc "find help"})
(map :n :<leader>fk fzf.keymaps {:desc "find keymaps"})
(map :n :<leader>fr fzf.resume {:desc "find resume"})
(map :n :<leader><space>
     (fn []
       (fzf.files {:cmd "rg --files --color=never --hidden -g \"!.git\" --sortr accessed"
                   :cwd_prompt false})) {:desc "Find recent files"})
