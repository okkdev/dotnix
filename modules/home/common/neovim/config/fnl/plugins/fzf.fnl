(local fzf (require :fzf-lua))

(fzf.setup {:winopts {:backdrop 95
                      :border [" " " " " " " " " " " " " " " "]
                      :preview {:border :noborder}}
            :fzf_opts {:--layout :default :--separator " " :--gutter " "}
            :fzf_colors true})

(local map vim.keymap.set)
(local file-rg-opts "--color=never --files --hidden -g \"!.git\" -g \"!.jj\"")

(map :n :<leader><space>
     (fn []
       (fzf.files {:rg_opts (.. file-rg-opts " --sortr accessed")
                   :cwd_prompt false})) {:desc "Find recent files"})

(map :n :<leader>ff (fn [] (fzf.files {:rg_opts file-rg-opts}))
     {:desc "find files"})

(map :n :<leader>f/
     (fn []
       (fzf.live_grep {:rg_opts "--column --line-number --no-heading --color=always --smart-case --max-columns=4096 --hidden -g \"!.git\" -g \"!.jj\" -e"}))
     {:desc "search files"})

(map :n :<leader>fg fzf.git_files {:desc "files git"})
(map :n :<leader>/ fzf.blines {:desc "Fuzzily search lines in current buffer"})
(map :n :<leader>fb fzf.buffers {:desc "find buffers"})
(map :n :<leader>fd fzf.diagnostics_workspace {:desc "find diagnostics"})
(map :n :<leader>fh fzf.helptags {:desc "find help"})
(map :n :<leader>fk fzf.keymaps {:desc "find keymaps"})
(map :n :<leader>fr fzf.resume {:desc "find resume"})
