; Mini Utilities

; Animations for resize/scroll/cursor with exclusion for mouse scrolling
; (let [animate (require :mini.animate)]
;   (var mouse_scrolled false)
;   (each [_ scroll (ipairs [:Up :Down])]
;     (local key (.. :<ScrollWheel scroll ">"))
;     (vim.keymap.set ["" :i] key (fn [] (set mouse_scrolled true) key)
;                     {:expr true}))
;   (animate.setup {:cursor {:timing (animate.gen_timing.linear {:duration 100
;                                                                :unit :total})}
;                   :resize {:timing (animate.gen_timing.linear {:duration 100
;                                                                :unit :total})}
;                   :scroll {:subscroll (animate.gen_subscroll.equal {:predicate (fn [total-scroll]
;                                                                                  (if mouse_scrolled
;                                                                                      (do
;                                                                                        (set mouse_scrolled
;                                                                                             false)
;                                                                                        false)
;                                                                                      vim.g.neovide
;                                                                                      false
;                                                                                      (> total-scroll
;                                                                                         1)))})
;                            :timing (animate.gen_timing.linear {:duration 125
;                                                                :unit :total})}}))

; Highlight words under cursor
(let [cursorword (require :mini.cursorword)]
  (cursorword.setup))

; Comment lines with gc/gcc
(let [cmt (require :mini.comment)]
  (cmt.setup))

; Improved a/i around and inside command
(let [ai (require :mini.ai)]
  (ai.setup))

; Allows splitting lists/arrays onto multiple lines
(let [sj (require :mini.splitjoin)]
  (sj.setup))

; ; inserts [], ()... pairs
; (let [prs (require :mini.pairs)]
;   (prs.setup))

; s command to work with surrounding characters
(let [surround (require :mini.surround)]
  (surround.setup))

; Highlight NOTE/TODO or other patterns
; maybe:
; :note
; {:group :MiniHipatternsNote :pattern "%f[%w]()NOTE()%f[%W]"}
; :todo
; {:group :MiniHipatternsTodo :pattern "%f[%w]()TODO()%f[%W]"}
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

(let [statusline (require :mini.statusline)]
  (statusline.setup))

; (let [starter (require :mini.starter)]
;   (starter.setup {:header (table.concat ["   ⣴⣶⣤⡤⠦⣤⣀⣤⠆     ⣈⣭⣿⣶⣿⣦⣼⣆          "
;                                          "    ⠉⠻⢿⣿⠿⣿⣿⣶⣦⠤⠄⡠⢾⣿⣿⡿⠋⠉⠉⠻⣿⣿⡛⣦       "
;                                          "          ⠈⢿⣿⣟⠦ ⣾⣿⣿⣷    ⠻⠿⢿⣿⣧⣄     "
;                                          "           ⣸⣿⣿⢧ ⢻⠻⣿⣿⣷⣄⣀⠄⠢⣀⡀⠈⠙⠿⠄    "
;                                          "          ⢠⣿⣿⣿⠈    ⣻⣿⣿⣿⣿⣿⣿⣿⣛⣳⣤⣀⣀   "
;                                          "   ⢠⣧⣶⣥⡤⢄ ⣸⣿⣿⠘  ⢀⣴⣿⣿⡿⠛⣿⣿⣧⠈⢿⠿⠟⠛⠻⠿⠄  "
;                                          "  ⣰⣿⣿⠛⠻⣿⣿⡦⢹⣿⣷   ⢊⣿⣿⡏  ⢸⣿⣿⡇ ⢀⣠⣄⣾⠄   "
;                                          " ⣠⣿⠿⠛ ⢀⣿⣿⣷⠘⢿⣿⣦⡀ ⢸⢿⣿⣿⣄ ⣸⣿⣿⡇⣪⣿⡿⠿⣿⣷⡄  "
;                                          " ⠙⠃   ⣼⣿⡟  ⠈⠻⣿⣿⣦⣌⡇⠻⣿⣿⣷⣿⣿⣿ ⣿⣿⡇ ⠛⠻⢷⣄ "
;                                          "      ⢻⣿⣿⣄   ⠈⠻⣿⣿⣿⣷⣿⣿⣿⣿⣿⡟ ⠫⢿⣿⡆     "
;                                          "       ⠻⣿⣿⣿⣿⣶⣶⣾⣿⣿⣿⣿⣿⣿⣿⣿⡟⢀⣀⣤⣾⡿⠃     "]
;                                         "\n")
;                   :items [(starter.sections.recent_files 10 true true)]
;                   :content_hooks [(starter.gen_hook.adding_bullet)
;                                   (starter.gen_hook.aligning :center :top)]
;                   :footer ""
;                   :query_updaters :abcdefghilmnopqrstuvwxyz0123456789_-.}))

; ; Show indent scope
; (let [indent (require :mini.indentscope)]
;   (indent.setup {:symbol "▎"
;                  :draw {:delay 200
;                         :animation (indent.gen_animation.linear {:duration 5
;                                                                  :unit :step})}})
;   (local ins_filetypes [:elixir
;                         :gleam
;                         :html
;                         :javascript
;                         :nix
;                         :php
;                         :python
;                         :typescript])
;   (vim.api.nvim_create_autocmd :FileType
;                                {:pattern "*"
;                                 :callback (fn []
;                                             (when (not (vim.tbl_contains ins_filetypes
;                                                                          vim.bo.filetype))
;                                               (set vim.b.miniindentscope_disable
;                                                    true)))}))

