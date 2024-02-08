; Start page
(local alpha (require :alpha))
(local theta (require :alpha.themes.theta))

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

(set theta.config.layout [{:type :padding :val 2}
                          theta.header
                          {:type :padding :val 2}
                          section_mru])

(alpha.setup theta.config)

