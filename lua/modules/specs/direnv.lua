-- Category: tools

-- Direnv support
return {
    'direnv/direnv.vim',
    event = 'DirChangedPre',
    config = function()
        --- NOTE  Force load `mason` before direnv changes the value of `PATH`
        require 'mason'
    end,
}
