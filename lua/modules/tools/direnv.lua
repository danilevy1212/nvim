-- Direnv support
return {
    'direnv/direnv.vim',
    event = 'DirChangedPre',
    config = function()
        --- Load `mason` before direnv changes the value of `PATH`
        require 'mason'
        -- Use 'bash' parser for 'direnv' filetype
        vim.treesitter.language.register('bash', 'direnv')
    end,
}
