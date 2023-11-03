---Disable criteria. None for now
---@param lang string -- Filetype
---@param bufnr number -- Buffer number
---@return boolean
---@diagnostic disable-next-line: unused-local
local disable = function(lang, bufnr)
    return false
end

-- Treesitter support
return {
    'nvim-treesitter/nvim-treesitter',
    event = { 'BufRead' },
    build = ':TSUpdate',
    dependencies = {
        {
            'HiPhish/nvim-ts-rainbow2',
        },
    },
    config = function()
        require('nvim-treesitter').setup()

        -- NOTE  In case of failure, rotate these around, the first will get used
        require('nvim-treesitter.install').compilers = {
            'gcc',
            'cc',
            'clang++',
            'zig',
        }

        require('nvim-treesitter.configs').setup {
            -- A list of parser names, or "all"
            ensure_installed = {
                'bash',
                'commonlisp',
                'dockerfile',
                'javascript',
                'json',
                'jsonc',
                'lua',
                'markdown',
                'markdown_inline',
                'nix',
                'org',
                'rust',
                'ssh_config',
                'sql',
                'toml',
                'typescript',
                'vim',
                'vimdoc',
            },

            -- Install parsers synchronously (only applied to `ensure_installed`)
            sync_install = false,

            -- If a parser is missing, force me to add it to the ensure_installed list, for documentation sake
            auto_install = false,

            highlight = {
                -- Higlight by default
                enable = true,
                -- Disable when is too large
                disable = disable,
                -- Don't relay on regex highlight
                additional_vim_regex_highlighting = false,
            },

            -- Enable incremental selection
            incremental_selection = {
                enable = true,
                keymaps = {
                    init_selection = 'gnn',
                    node_incremental = 'grn',
                    scope_incremental = 'grc',
                    node_decremental = 'grm',
                },
            },

            -- Indentation based on treesitter for the = operator.
            indent = {
                enable = true,
            },

            -- Rainbow parens
            rainbow = {
                enable = true,
                -- list of languages you want to disable the plugin for
                disable = {},
                -- Which query to use for finding delimiters
                query = 'rainbow-parens',
                -- Highlight the entire buffer all at once
                strategy = require 'ts-rainbow.strategy.global',
                -- Default highlight groups
                hlgroups = {
                    'TSRainbowCyan',
                    'TSRainbowViolet',
                    'TSRainbowGreen',
                    'TSRainbowBlue',
                    'TSRainbowOrange',
                    'TSRainbowRed',
                    'TSRainbowYellow',
                },
            },
        }
    end,
}
