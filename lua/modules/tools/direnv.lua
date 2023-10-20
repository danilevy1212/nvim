-- Direnv support
return {
    'direnv/direnv.vim',
    event = 'DirChangedPre',
    --- Load `mason` before direnv changes the value of `PATH`
    dependencies = { 'williamboman/mason.nvim' },
    config = function()
        -- Use 'bash' parser for 'direnv' filetype
        vim.treesitter.language.register('bash', 'direnv')
    end,
}
