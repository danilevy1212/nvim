-- Category: editor

-- Treesitter support
return {
    'nvim-treesitter/nvim-treesitter',
    event = 'BufRead',
    run = ':TSUpdate',
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
                'help',
                'bash',
                'markdown',
                'markdown_inline',
                'javascript',
                'typescript',
                'c',
                'lua',
                'rust',
                'vim',
                'commonlisp',
                'toml',
                'nix',
                'dockerfile',
                'sql',
            },

            -- Install parsers synchronously (only applied to `ensure_installed`)
            sync_install = false,

            -- If a parser is missing, force me to add it to the ensure_installed list, for documentation sake
            auto_install = false,

            highlight = {
                -- Higlight by default
                enable = true,

                -- Don't relay on regex highlight
                additional_vim_regex_highlighting = false,
            },
        }

        -- Reuse parser for specific filetypes
        local ft_to_parser = require('nvim-treesitter.parsers').filetype_to_parsername

        -- Use 'bash' parser for 'direnv' filetype
        ft_to_parser.direnv = 'bash'
    end,
}
