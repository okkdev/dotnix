(local mkv (require :markview))

(mkv.setup {:preview {:filetypes [:markdown :quarto :rmd :codecompanion]
                      :ignore_buftypes {}}})
