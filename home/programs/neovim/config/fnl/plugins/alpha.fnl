; Start page
(local alpha (require :alpha))
(local theta (require :alpha.themes.theta))
;(local abra (require :abra))

(local section_mru
       {:type :group
        :val [{:opts {:hl :SpecialComment
                      :position :center
                      :shrink_margin false}
               :type :text
               :val "Recent files"}
              {:type :padding :val 1}
              {:opts {:shrink_margin false}
               :type :group
               :val (fn []
                      [(theta.mru 0 (vim.fn.getcwd))])}]})

(set theta.header.val
     ["   ⣴⣶⣤⡤⠦⣤⣀⣤⠆     ⣈⣭⣿⣶⣿⣦⣼⣆          "
      "    ⠉⠻⢿⣿⠿⣿⣿⣶⣦⠤⠄⡠⢾⣿⣿⡿⠋⠉⠉⠻⣿⣿⡛⣦       "
      "          ⠈⢿⣿⣟⠦ ⣾⣿⣿⣷    ⠻⠿⢿⣿⣧⣄     "
      "           ⣸⣿⣿⢧ ⢻⠻⣿⣿⣷⣄⣀⠄⠢⣀⡀⠈⠙⠿⠄    "
      "          ⢠⣿⣿⣿⠈    ⣻⣿⣿⣿⣿⣿⣿⣿⣛⣳⣤⣀⣀   "
      "   ⢠⣧⣶⣥⡤⢄ ⣸⣿⣿⠘  ⢀⣴⣿⣿⡿⠛⣿⣿⣧⠈⢿⠿⠟⠛⠻⠿⠄  "
      "  ⣰⣿⣿⠛⠻⣿⣿⡦⢹⣿⣷   ⢊⣿⣿⡏  ⢸⣿⣿⡇ ⢀⣠⣄⣾⠄   "
      " ⣠⣿⠿⠛ ⢀⣿⣿⣷⠘⢿⣿⣦⡀ ⢸⢿⣿⣿⣄ ⣸⣿⣿⡇⣪⣿⡿⠿⣿⣷⡄  "
      " ⠙⠃   ⣼⣿⡟  ⠈⠻⣿⣿⣦⣌⡇⠻⣿⣿⣷⣿⣿⣿ ⣿⣿⡇ ⠛⠻⢷⣄ "
      "      ⢻⣿⣿⣄   ⠈⠻⣿⣿⣿⣷⣿⣿⣿⣿⣿⡟ ⠫⢿⣿⡆     "
      "       ⠻⣿⣿⣿⣿⣶⣶⣾⣿⣿⣿⣿⣿⣿⣿⣿⡟⢀⣀⣤⣾⡿⠃     "])

;(set theta.header.val (let [cmd (io.popen "krabby random --no-title")
;                           out (cmd:read :*a)
;                          res (let [acc []]
;                               (each [_ line (ipairs (out:gmatch "([^\n]+)"))]
;                              (table.insert acc line)))]
;                   (cmd:close)
;                  res))

;(abra.set_colors)
;(set theta.header.val abra.sprite)
;(set theta.header.opts.hl abra.hl)


(set theta.config.layout [{:type :padding :val 2}
                          theta.header
                          {:type :padding :val 1}
                          section_mru])

(alpha.setup theta.config)

