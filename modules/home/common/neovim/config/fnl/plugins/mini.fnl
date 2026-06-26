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

  (local jj_cache {})

  (fn update_jj_bookmark [bufnr]
    (when (= (. (. vim.bo bufnr) :buftype) "")
     (let [file (vim.api.nvim_buf_get_name bufnr)
           dir (if (= file "") (vim.fn.getcwd) (vim.fn.fnamemodify file ":h"))]
       (vim.system [:jj :log :--no-graph :--ignore-working-copy
                    :--color :never :--limit "1"
                    :-r "heads(::@ & bookmarks())"
                    :-T "bookmarks.map(|b| b.name()).join(\",\")"]
                   {:cwd dir :text true}
                   (fn [result]
                     (let [out (vim.trim (or result.stdout ""))]
                       (vim.schedule #(do
                                        (tset jj_cache bufnr
                                              (if (not= result.code 0) nil
                                                  (= out "") ""
                                                  (.. "" " " out)))
                                        (pcall vim.cmd.redrawstatus)))))))))

  (let [group (vim.api.nvim_create_augroup :MiniStatuslineJJ {:clear true})]
    (vim.api.nvim_create_autocmd [:BufEnter :FocusGained :DirChanged
                                  :BufWritePost]
                                 {: group
                                  :callback (fn [args]
                                              (update_jj_bookmark args.buf))}))

  ; Prefer jj closest bookmark when inside a jj repo; otherwise fall back to
  ; mini's git section.
  (fn section_vcs [args]
    (or (. jj_cache (vim.api.nvim_get_current_buf))
        (statusline.section_git args)))

  ; Display filename: full path when space available, just name when truncated
  (fn section_filename [args]
    (if (= vim.bo.buftype :terminal) "%t"
        (= vim.bo.buftype :nofile) ""
        (statusline.is_truncated args.trunc_width) (.. (vim.fn.expand "%:t")
                                                       " %m%r")
        (.. (vim.fn.expand "%:~:.") " %m%r")))

  ; Display filetype with icon from nvim-web-devicons
  (fn section_fileinfo [args]
    (if (statusline.is_truncated args.trunc_width)
        ""
        (let [filetype vim.bo.filetype]
          (when (or (not= filetype "") (= vim.bo.buftype ""))
            (local file_name (vim.fn.expand "%:t"))
            (local file_ext (vim.fn.expand "%:e"))
            (local icon (devicons.get_icon file_name file_ext {:default true}))
            (if (not= icon "")
                (string.format "%s %s" icon filetype)
                filetype)))))

  ; Display cursor location: column|total-cols line|total-lines percentage
  (fn section_location [args]
    (if (statusline.is_truncated args.trunc_width) "%l|%L"
        "%2v|%-2{virtcol(\"$\") - 1} %l|%L %3P"))

  ; Combine statusline groups with highlight groups and optional rounded separators
  (fn combine_groups [groups]
    (table.concat (vim.tbl_map (fn [s]
                                 (if (= (type s) :string)
                                     s
                                     (do
                                       (local str
                                              (table.concat (icollect [_ v (ipairs s.strings)]
                                                              (if (not= v "") v))
                                                            " "))
                                       (if (= (length str) 0)
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

  (set statusline.inactive
       (fn []
         (.. "%=" (section_filename {:trunc_width 75}) "%=")))
  (set statusline.active
       (fn []
         (let [(mode mode_hl) (statusline.section_mode {:trunc_width 120})
               vcs (section_vcs {:trunc_width 75})
               filename (section_filename {:trunc_width 75})
               fileinfo (section_fileinfo {:trunc_width 100})
               search (statusline.section_searchcount {:trunc_width 75})
               location (section_location {:trunc_width 100})]
           (combine_groups [{:hl mode_hl :strings [mode] :rounded false}
                            ; " "
                            {:hl :MiniStatuslineDevinfo
                             :strings [vcs]
                             :rounded false}
                            "%<"
                            {:hl :MiniStatuslineFilename :strings [filename]}
                            "%="
                            (if (not= (vim.fn.reg_recording) "")
                                {:hl :MiniStatuslineFileinfo
                                 :strings [(.. "Recording @"
                                               (vim.fn.reg_recording))]
                                 :rounded false}
                                "")
                            ; " "
                            {:hl :MiniStatuslineFileinfo
                             :strings [fileinfo]
                             :rounded false}
                            ; " "
                            {:hl mode_hl
                             :strings [search location]
                             :rounded false}])))))

; Create reverse highlight colors for statusline separators
; This generates highlight groups with reversed foreground colors (using bg as fg)
; to create seamless transitions between statusline sections
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
