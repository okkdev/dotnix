require "tangerine".setup {
    target = vim.fn.stdpath [[config]],

    compiler = {
        -- disable popup showing compiled files
        verbose = false,

        -- compile every time you change fennel files or on entering vim
        hooks = {"oninit"}
    }
}
