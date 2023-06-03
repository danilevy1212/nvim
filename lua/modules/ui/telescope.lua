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
                return vim.fn.expand '%:p:h'
            end

            require('which-key').register({
                ['<leader>'] = {
                    function()
                        if vim.fn.isdirectory(vim.fn.getcwd() .. '/.git') == 1 then
                            require('telescope.builtin').git_files {
                                show_untracked = true,
                            }
                        else
                            require('telescope.builtin').find_files {
                                hidden = true,
                            }
                        end
                    end,
                    'Find a file in CWD',
                },
                ['/'] = {
                    function()
                        require('telescope.builtin').live_grep(require('telescope.themes').get_ivy())
                    end,
                    'Find a string in CWD',
                },
                s = {
                    s = {
                        function()
                            require('telescope.builtin').current_buffer_fuzzy_find(require('telescope.themes').get_ivy {
                                previewer = false,
                            })
                        end,
                        'Find string in buffer',
                    },
                    ['/'] = {
                        function()
                            require('telescope.builtin').live_grep(
                                require('telescope.themes').get_ivy { cwd = get_buffer_dir() }
                            )
                        end,
                        'Find a string in directory',
                    },
                    d = {
                        function()
                            require('telescope.builtin').find_files {
                                cwd = get_buffer_dir(),
                            }
                        end,
                        'Find file in buffer directory',
                    },
                },
                b = {
                    b = {
                        function()
                            require('telescope.builtin').buffers()
                        end,
                        'Find live buffers',
                    },
                },
                f = {
                    r = {
                        function()
                            require('telescope.builtin').oldfiles()
                        end,
                        'Find in previously open files',
                    },
                },
                h = {
                    t = {
                        function()
                            require('telescope.builtin').help_tags()
                        end,
                        'Help Tags',
                    },
                    o = {
                        function()
                            require('telescope.builtin').vim_options()
                        end,
                        'Options (vim.opt)',
                    },
                    k = {
                        function()
                            require('telescope.builtin').keymaps()
                        end,
                        'Find Keybinding',
                    },
                },
            }, {
                prefix = '<leader>',
            })
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
