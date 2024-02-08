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
                                                                                     (> total-scroll
                                                                                        1)))})
                           :timing (animate.gen_timing.linear {:duration 100
                                                               :unit :total})}}))

(let [cursorword (require :mini.cursorword)]
  (cursorword.setup))

(let [cmt (require :mini.comment)]
  (cmt.setup))

(let [ai (require :mini.ai)]
  (ai.setup))

(let [sj (require :mini.splitjoin)]
  (sj.setup))

(let [prs (require :mini.pairs)]
  (prs.setup))

(let [surround (require :mini.surround)]
  (surround.setup))

(let [hipatterns (require :mini.hipatterns)]
  (hipatterns.setup {:highlighters {:note {:group :MiniHipatternsNote
                                           :pattern "%f[%w]()NOTE()%f[%W]"}
                                    :todo {:group :MiniHipatternsTodo
                                           :pattern "%f[%w]()TODO()%f[%W]"}
                                    :hex_color (hipatterns.gen_highlighter.hex_color)}}))

(let [indent (require :mini.indentscope)]
  (indent.setup {:symbol "▎"
                 :draw {:animation (indent.gen_animation.linear {:duration 10
                                                                 :unit :step})}}))

