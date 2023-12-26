--- Adds indentation guides to all lines (including empty lines).

return {
    'lukas-reineke/indent-blankline.nvim',
    event = { 'BufReadPost' },
    config = function()
        require('ibl').setup {
            scope = {
                enabled = true,
                show_start = true,
                show_end = true,
            },
        }
    end,
}
