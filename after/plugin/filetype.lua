vim.filetype.add {
    --- Register anko as a filetype
    extension = {
        anko = 'anko',
        ank = 'anko',
    },
    pattern = {
        --- Register `.example` files as `sh` filetypes
        ['.env.example'] = 'sh',
    },
}

--- Anko syntax is close enough to golang
vim.treesitter.language.register('go', 'anko')
