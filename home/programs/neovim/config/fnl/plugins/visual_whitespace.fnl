(local vw (require :visual-whitespace))

(vw.setup {})

(let [fg (. (vim.api.nvim_get_hl 0 {:name :NonText}) :fg)
      bg (. (vim.api.nvim_get_hl 0 {:name :Visual}) :bg)]
  (vim.api.nvim_set_hl 0 :VisualNonText {: fg : bg}))
