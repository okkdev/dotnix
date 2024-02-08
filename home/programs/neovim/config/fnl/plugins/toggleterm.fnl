; quick terminal modal
(let [config (require :toggleterm)]
  (config.setup {:direction :float :open_mapping :<c-j>}))

