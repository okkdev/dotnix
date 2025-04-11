; Mini Utilities

; Improved a/i around and inside command
(let [ai (require :mini.ai)
      spec ai.gen_spec]
  (ai.setup {:custom_textobjects {:F (spec.treesitter {:a "@function.outer"
                                                       :i "@function.inner"})}}))

; Allows splitting lists/arrays onto multiple lines
(let [sj (require :mini.splitjoin)]
  (sj.setup))

; s command to work with surrounding characters
(let [surround (require :mini.surround)]
  (surround.setup))

; Highlight patterns
(let [hipatterns (require :mini.hipatterns)]
  (hipatterns.setup {:highlighters {:hex_color (hipatterns.gen_highlighter.hex_color)}}))

(let [clue (require :mini.clue)]
  (clue.setup {:clues [(clue.gen_clues.builtin_completion)
                       (clue.gen_clues.g)
                       (clue.gen_clues.marks)
                       (clue.gen_clues.registers)
                       (clue.gen_clues.windows)
                       (clue.gen_clues.z)]
               :triggers [{:keys :<Leader> :mode :n}
                          {:keys :<Leader> :mode :x}
                          {:keys :<C-x> :mode :i}
                          {:keys :g :mode :n}
                          {:keys :g :mode :x}
                          {:keys "'" :mode :n}
                          {:keys "`" :mode :n}
                          {:keys "'" :mode :x}
                          {:keys "`" :mode :x}
                          {:keys "\"" :mode :n}
                          {:keys "\"" :mode :x}
                          {:keys :<C-r> :mode :i}
                          {:keys :<C-r> :mode :c}
                          {:keys :<C-w> :mode :n}
                          {:keys :z :mode :n}
                          {:keys :z :mode :x}]
               :window {:config {:width :auto :border :solid}}}))

; Status line
(let [statusline (require :mini.statusline)
      devicons (require :nvim-web-devicons)]
  (statusline.setup {:use_icons true})

  (fn section_filename [args]
    (if (= vim.bo.buftype :terminal) "%t"
        (= vim.bo.buftype :nofile) ""
        (statusline.is_truncated args.trunc_width) (.. (vim.fn.expand "%:t")
                                                       " %m%r")
        (.. (vim.fn.expand "%:~:.") " %m%r")))

  (fn section_fileinfo [_args]
    (let [filetype vim.bo.filetype]
      (when (or (not= filetype "") (= vim.bo.buftype ""))
        (local file_name (vim.fn.expand "%:t"))
        (local file_ext (vim.fn.expand "%:e"))
        (local icon (devicons.get_icon file_name file_ext {:default true}))
        (if (not= icon "")
            (string.format "%s %s" icon filetype)
            filetype))))

  (fn combine_groups [groups]
    (table.concat (vim.tbl_map (fn [s]
                                 (if (= (type s) :string)
                                     s
                                     (do
                                       (local str (table.concat s.strings " "))
                                       (if (= (str:len) 0)
                                           (string.format "%%#%s#" s.hl)
                                           (= s.hl nil)
                                           (string.format " %s " str)
                                           (= s.rounded true)
                                           (let [rev_hl (.. :rev_ s.hl)]
                                             (string.format "%%#%s#%%#%s#%s%%#%s#"
                                                            rev_hl s.hl str
                                                            rev_hl))
                                           (string.format "%%#%s# %s " s.hl str)))))
                               groups) ""))

  (fn section_location []
    (let [sbar ["🭶" "🭷" "🭸" "🭹" "🭺" "🭻"]
          curr_line (. (vim.api.nvim_win_get_cursor 0) 1)
          lines (vim.api.nvim_buf_line_count 0)
          i (+ (math.floor (* (/ (- curr_line 1) lines) (length sbar))) 1)]
      (.. "%l " (. sbar i) " %L")))

  (set statusline.inactive (fn [] ""))
  (set statusline.active
       (fn []
         (let [(mode mode_hl) (statusline.section_mode {:trunc_width 120})
               git (statusline.section_git {:trunc_width 75})
               filename (section_filename {:trunc_width 140})
               fileinfo (section_fileinfo {:trunc_width 120})
               search (statusline.section_searchcount {:trunc_width 75})
               location (section_location)]
           (combine_groups [{:hl mode_hl :strings [mode] :rounded true}
                            " "
                            {:hl :MiniStatuslineDevinfo
                             :strings [git]
                             :rounded true}
                            "%<"
                            {:hl :MiniStatuslineFilename :strings [filename]}
                            "%="
                            (if (not= (vim.fn.reg_recording) "")
                                {:hl :MiniStatuslineFileinfo
                                 :strings [(.. "Recording @"
                                               (vim.fn.reg_recording))]
                                 :rounded true}
                                "")
                            " "
                            {:hl :MiniStatuslineFileinfo
                             :strings [fileinfo]
                             :rounded true}
                            " "
                            {:hl mode_hl
                             :strings [search location]
                             :rounded true}])))))

; create reverse highlight colors
(let [autocmd vim.api.nvim_create_autocmd]
  (autocmd [:Colorscheme :UIEnter]
           {:callback (fn []
                        (fn reverse_hl [name]
                          (let [color (vim.api.nvim_get_hl 0 {: name})
                                rev_name (.. :rev_ name)]
                            (if (= color.bg nil)
                                (vim.api.nvim_set_hl 0 rev_name
                                                     {:link (.. :rev_
                                                                color.link)})
                                (vim.api.nvim_set_hl 0 rev_name {:fg color.bg}))))

                        (let [hl_groups [:MiniStatuslineModeNormal
                                         :MiniStatuslineModeInsert
                                         :MiniStatuslineModeVisual
                                         :MiniStatuslineModeReplace
                                         :MiniStatuslineModeCommand
                                         :MiniStatuslineModeOther
                                         :MiniStatuslineDevinfo
                                         :MiniStatuslineFilename
                                         :MiniStatuslineFileinfo
                                         :MiniStatuslineInactive]]
                          (each [_ group (pairs hl_groups)]
                            (reverse_hl group))))}))
