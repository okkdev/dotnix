require "tangerine".setup {
    target = vim.fn.stdpath [[config]],

    compiler = {
        -- disable popup showing compiled files
        verbose = false,
    }
}
