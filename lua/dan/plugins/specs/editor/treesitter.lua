--- Treesitter enhancements for Neovim

--- @type LazyPluginSpec
local M = {
    'nvim-treesitter/nvim-treesitter',
    event = { 'BufRead' },
    build = ':TSUpdate',
    dependencies = {
        {
            --- This Neovim plugin provides alternating syntax highlighting (“rainbow parentheses”) for Neovim, powered by Tree-sitter.
            'HiPhish/rainbow-delimiters.nvim',
            --- Submodules for this plugin are dev dependencies and should not be installed
            submodules = false,
            enabled = true,
            init = function()
                vim.g.rainbow_delimiters = {
                    highlight = {
                        'RainbowDelimiterCyan',
                        'RainbowDelimiterViolet',
                        'RainbowDelimiterGreen',
                        'RainbowDelimiterBlue',
                        'RainbowDelimiterOrange',
                        'RainbowDelimiterRed',
                        'RainbowDelimiterYellow',
                    },
                }
            end,
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
            ensure_installed = 'all',
            ignore_install = {},
            -- Install parsers synchronously (only applied to `ensure_installed`)
            sync_install = false,
            -- Install all parsers so we can assume we always have treesitter available
            auto_install = true,
            highlight = {
                -- Highlight by default
                enable = true,
                ---Disable criteria. None for now
                ---@param lang string -- Filetype
                ---@param bufnr number -- Buffer number
                ---@return boolean
                ---@diagnostic disable-next-line: unused-local
                disable = function(lang, bufnr)
                    return false
                end,
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
            modules = {},
        }
    end,
}

return M
