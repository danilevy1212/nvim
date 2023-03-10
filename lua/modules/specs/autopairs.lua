-- Category: editor

return {
    'windwp/nvim-autopairs',
    after = 'nvim-treesitter',
    event = 'BufRead',
    config = function()
        require('nvim-autopairs').setup {
            disable_filetype = { 'TelescopePrompt', 'vim' },
            check_ts = true,
        }
    end,
}
