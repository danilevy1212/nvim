-- Bootstrap lazy.nvim
local lazypath = vim.fn.stdpath 'data' .. '/lazy/lazy.nvim'
if not vim.loop.fs_stat(lazypath) then
    vim.fn.system {
        'git',
        'clone',
        '--filter=blob:none',
        'https://github.com/folke/lazy.nvim.git',
        '--branch=stable', -- latest stable release
        lazypath,
    }
end
vim.opt.rtp:prepend(lazypath)

-- Make sure to set `mapleader` before lazy so your mappings are correct
vim.g.mapleader = ' '

-- Setup lazy
require('lazy').setup {
    --- Defaults
    defaults = {
        lazy = true,
    },
    -- Load plugins by category
    spec = vim.tbl_map(function(spec_category)
        return {
            import = 'modules.' .. spec_category,
        }
    end, {
        'core',
        'configuration',
        'organization',
        'ui',
        'editor',
        'tools',
        'filetype',
    }),
    -- I don't use nerd fonts, so I need to configure each symbol
    ui = {
        icons = {
            cmd = '⌘',
            config = '🛠',
            event = '📅',
            ft = '📂',
            init = '⚙',
            keys = '🗝',
            plugin = '🔌',
            runtime = '💻',
            source = '📄',
            start = '🚀',
            task = '📌',
            lazy = '💤 ',
        },
    },
}
