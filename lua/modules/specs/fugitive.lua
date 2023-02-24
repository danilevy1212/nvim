-- Category: tools

-- Magit lesser brother
return {
    'tpope/vim-fugitive',
    cmd = { 'Git', 'G' },
    requires = {
        -- Make GBrowse work on gitlab
        {
            'shumphrey/fugitive-gitlab.vim',
            after = 'vim-fugitive',
        },
        --  and github
        {
            'tpope/vim-rhubarb',
            after = 'vim-fugitive',
        },
    },
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
                b = {
                    function ()
                        vim.cmd [[GBrowse]]
                    end,
                    'open remote in browser'
                }
            },
        }, {
            prefix = '<leader>',
        })
    end,
}
