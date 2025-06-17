(local dial (require :dial.config))
(local augend (require :dial.augend))
(local dmap (require :dial.map))

(dial.augends:register_group {:default [augend.integer.alias.decimal
                                        augend.integer.alias.decimal_int
                                        augend.integer.alias.hex
                                        (. augend.date.alias "%Y/%m/%d")
                                        (. augend.date.alias "%Y-%m-%d")
                                        (. augend.date.alias "%m/%d")
                                        (. augend.date.alias "%H:%M")
                                        augend.constant.alias.bool
                                        (augend.constant.new {:elements [:True
                                                                         :False]
                                                              :word true
                                                              :cyclic true})]})

(local map vim.keymap.set)

(map [:n] :<C-a> #(dmap.manipulate :increment :normal) {:desc "dial increment"})

(map [:n] :<C-x> #(dmap.manipulate :decrement :normal) {:desc "dial decrement"})

(map [:n] :g<C-a> #(dmap.manipulate :increment :gnormal)
     {:desc "dial increment"})

(map [:n] :g<C-x> #(dmap.manipulate :decrement :gnormal)
     {:desc "dial decrement"})

(map [:v] :<C-a> #(dmap.manipulate :increment :visual) {:desc "dial increment"})

(map [:v] :<C-x> #(dmap.manipulate :decrement :visual) {:desc "dial decrement"})

(map [:v] :g<C-a> #(dmap.manipulate :increment :gvisual)
     {:desc "dial increment"})

(map [:v] :g<C-x> #(dmap.manipulate :decrement :gvisual)
     {:desc "dial decrement"})
