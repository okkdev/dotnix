; Mini Utilities

; Animations for resize/scroll/cursor with exclusion for mouse scrolling
(let [animate (require :mini.animate)]
  (var mouse_scrolled false)
  (each [_ scroll (ipairs [:Up :Down])]
    (local key (.. :<ScrollWheel scroll ">"))
    (vim.keymap.set ["" :i] key (fn [] (set mouse_scrolled true) key)
                    {:expr true}))
  (animate.setup {:cursor {:timing (animate.gen_timing.linear {:duration 100
                                                               :unit :total})}
                  :resize {:timing (animate.gen_timing.linear {:duration 100
                                                               :unit :total})}
                  :scroll {:subscroll (animate.gen_subscroll.equal {:predicate (fn [total-scroll]
                                                                                 (if mouse_scrolled
                                                                                     (do
                                                                                       (set mouse_scrolled
                                                                                            false)
                                                                                       false)
                                                                                     vim.g.neovide
                                                                                     false
                                                                                     (> total-scroll
                                                                                        1)))})
                           :timing (animate.gen_timing.linear {:duration 125
                                                               :unit :total})}}))

; Highlight words under cursor
(let [cursorword (require :mini.cursorword)]
  (cursorword.setup))

; Comment lines with gc/gcc
(let [cmt (require :mini.comment)]
  (cmt.setup))

; Improved a/i around and inner command
(let [ai (require :mini.ai)]
  (ai.setup))

; Allows splitting lists/arrays onto multiple lines
(let [sj (require :mini.splitjoin)]
  (sj.setup))

; inserts [], ()... pairs
(let [prs (require :mini.pairs)]
  (prs.setup))

; s command to work with surrounding characters
(let [surround (require :mini.surround)]
  (surround.setup))

; Highlight NOTE/TODO or other patterns
(let [hipatterns (require :mini.hipatterns)]
  (hipatterns.setup {:highlighters {:note {:group :MiniHipatternsNote
                                           :pattern "%f[%w]()NOTE()%f[%W]"}
                                    :todo {:group :MiniHipatternsTodo
                                           :pattern "%f[%w]()TODO()%f[%W]"}
                                    :hex_color (hipatterns.gen_highlighter.hex_color)}}))

; Show indent scope
(let [indent (require :mini.indentscope)]
  (indent.setup {:symbol "▎"
                 :draw {:delay 200
                        :animation (indent.gen_animation.linear {:duration 5
                                                                 :unit :step})}}))

