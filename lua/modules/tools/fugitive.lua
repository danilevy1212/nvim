-- Magit lesser brother
return {
    'tpope/vim-fugitive',
    cmd = { 'Git', 'G', 'GBrowse' },
    dependencies = {
        -- Make GBrowse work on gitlab
        {
            'shumphrey/fugitive-gitlab.vim',
        },
        --  and github
        {
            'tpope/vim-rhubarb',
        },
    },
    init = function()
        require('which-key').register({
            g = {
                name = 'git',
                g = {
                    function()
                        vim.cmd [[G]]
                    end,
                    'status',
                },
                b = {
                    function()
                        vim.cmd [[GBrowse]]
                    end,
                    'open remote in browser',
                },
                B = {
                    function()
                        vim.cmd [[GBrowse!]]
                    end,
                    'copy browser link to clipboard',
                },
            },
        }, {
            prefix = '<leader>',
            mode = { 'n', 'v' },
        })
    end,
}
