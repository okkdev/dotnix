; Nvim settings
(local o vim.opt)
(local g vim.g)

; something to speed up loading idk
(vim.loader.enable)

(set o.autoindent true)
(set o.autoread true)
(set o.breakindent true)
(set o.clipboard :unnamedplus)
(set o.confirm true)
(set o.cursorline true)
(set o.expandtab true)
(set o.hlsearch true)
(set o.ignorecase true)
(set o.inccommand :split)
(set o.incsearch true)
(set o.infercase true)
(set o.linebreak true)
(set o.list false)
(set o.listchars {:tab "⇥ " :trail "·" :nbsp "␣" :space "·"})
(set o.fillchars {:eob " "})
(set o.mouse :a)
(set o.nu true)
(set o.number true)
(set o.relativenumber true)
(set o.ruler false)
(set o.scrolloff 15)
(set o.shiftwidth 2)
(set o.showmode false)
(set o.signcolumn :yes)
(set o.smartcase true)
(set o.smartindent true)
(set o.smoothscroll true)
(set o.softtabstop 2)
(set o.splitbelow true)
(set o.splitright true)
(set o.tabstop 2)
(set o.termguicolors true)
(set o.undofile true)
(set o.virtualedit :block)
(set o.wrap false)

(set g.loaded_netrw 1)
(set g.loaded_netrwPlugin 1)

