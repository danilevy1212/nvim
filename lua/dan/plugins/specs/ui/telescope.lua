-- Category: completion

return {
    {
        'nvim-telescope/telescope.nvim',
        cmd = { 'Telescope' },
        -- Load quickfix customizations in case we `send_to_quickfix` from telescope
        dependencies = {
            {
                'ten3roberts/qf.nvim',
            },
        },
        -- Set the keymaps to setup lazy loading
        init = function()
            local get_buffer_dir = function()
                return vim.fn.expand('%:p:h'):gsub('^[^:]+://', '')
            end

            require('which-key').add {
                {
                    '<leader><leader>',
                    function()
                        local function find_command()
                            if 1 == vim.fn.executable 'fd' then
                                return {
                                    'fd',
                                    '--type',
                                    'f',
                                    '--color',
                                    'never',
                                    '--exclude',
                                    '.git',
                                    '--exclude',
                                    '.yarn/cache',
                                }
                            elseif 1 == vim.fn.executable 'rg' then
                                return {
                                    'rg',
                                    '--files',
                                    '--color',
                                    'never',
                                    '--glob',
                                    '!*/.git/*',
                                    '--glob',
                                    '!*/.yarn/cache/*',
                                }
                            elseif 1 == vim.fn.executable 'find' then
                                return {
                                    'find',
                                    '.',
                                    '-type',
                                    'f',
                                    '-not',
                                    '-path',
                                    '*/.git/*',
                                    '-not',
                                    '-path',
                                    '*/.yarn/cache/*',
                                }
                            end
                            vim.notify('Could not find a valid file searcher', vim.log.levels.ERROR, {
                                title = 'telescope.builtin.find_files',
                            })
                        end
                        require('telescope.builtin').find_files {
                            hidden = true,
                            find_command = find_command,
                        }
                    end,
                    desc = 'Find a file in CWD',
                },
                {
                    '<leader>/',
                    function()
                        require('telescope.builtin').live_grep(require('telescope.themes').get_ivy())
                    end,
                    desc = 'Find a string in CWD',
                },
                {
                    '<leader>bb',
                    function()
                        require('telescope.builtin').buffers()
                    end,
                    desc = 'Find live buffers',
                },
                {
                    '<leader>fr',
                    function()
                        require('telescope.builtin').oldfiles()
                    end,
                    desc = 'Find in previously open files',
                },
                {
                    '<leader>hk',
                    function()
                        require('telescope.builtin').keymaps()
                    end,
                    desc = 'Find Keybinding',
                },
                {
                    '<leader>ho',
                    function()
                        require('telescope.builtin').vim_options()
                    end,
                    desc = 'Options (vim.opt)',
                },
                {
                    '<leader>ht',
                    function()
                        require('telescope.builtin').help_tags()
                    end,
                    desc = 'Help Tags',
                },
                {
                    '<leader>s/',
                    function()
                        require('telescope.builtin').live_grep(
                            require('telescope.themes').get_ivy { cwd = get_buffer_dir() }
                        )
                    end,
                    desc = 'Find a string in directory',
                },
                {
                    '<leader>sd',
                    function()
                        require('telescope.builtin').find_files { cwd = get_buffer_dir() }
                    end,
                    desc = 'Find file in buffer directory',
                },
                {
                    '<leader>ss',
                    function()
                        require('telescope.builtin').current_buffer_fuzzy_find(
                            require('telescope.themes').get_ivy { previewer = false }
                        )
                    end,
                    desc = 'Find string in buffer',
                },
            }
        end,
        config = function()
            -- Setup is required
            require('telescope').setup {
                defaults = {
                    -- When running in a GUI, give some transparency to telescope window
                    winblend = 30,
                    preview = {
                        hide_on_startup = true,
                    },
                    mappings = {
                        i = {
                            ['<A-p>'] = require('telescope.actions.layout').toggle_preview,
                            ['<C-space>'] = require('telescope.actions').to_fuzzy_refine,
                        },
                        n = {
                            P = require('telescope.actions.layout').toggle_preview,
                        },
                    },
                },
                extensions = {
                    aerial = {
                        -- Display symbols as <root>.<parent>.<symbol>
                        show_nesting = {
                            ['_'] = true,
                        },
                    },
                },
            }
        end,
    },
    {
        -- Use fzf algorithm for sorting
        {
            'nvim-telescope/telescope-fzf-native.nvim',
            build = 'make',
            config = function()
                require('telescope').load_extension 'fzf'
            end,
        },
    },
}
