--- Bootstrap lazy.nvim
local lazypath = vim.fn.stdpath 'data' .. '/lazy/lazy.nvim'
if not vim.uv.fs_stat(lazypath) then
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

local categories = {
    'meta',
    'organization',
    'ui',
    'editor',
    'libraries',
    'tools',
    'filetype',
}

--- @type LazyConfig
local opts = {
    dev = {
        path = vim.fn.stdpath 'config' .. '/lua/dan/plugins/local',
        patterns = { 'dan' },
    },
    --- Defaults
    defaults = {
        lazy = true,
    },
    --- Load plugins by category
    spec = vim.tbl_map(function(c)
        return { import = 'dan.plugins.specs.' .. c }
    end, categories),
    --- I don't use nerd fonts, so I need to configure each symbol
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
    install = {
        colorscheme = {
            'nord',
        },
    },
}

-- Setup lazy
require('lazy').setup(opts)
