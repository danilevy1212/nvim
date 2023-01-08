-- Category: tools

-- Magit lesser brother
return {
    'tpope/vim-fugitive',
    cmd = { 'Git', 'G' },
    setup = function()
        require('which-key').register({
            g = {
                name = 'git',
                g = {
                    function()
                        vim.cmd [[G]]
                    end,
                    'status',
                },
            },
        }, {
            prefix = '<leader>',
        })
    end,
}
