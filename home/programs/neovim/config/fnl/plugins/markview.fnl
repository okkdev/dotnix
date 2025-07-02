(local mkv (require :markview))

(mkv.setup {:preview {:filetypes [:markdown :quarto :rmd :typst :codecompanion]
                      :ignore_buftypes {}}})
