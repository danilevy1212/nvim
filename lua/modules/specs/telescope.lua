-- Category: completion

return {
    'nvim-telescope/telescope.nvim',
    module = 'telescope',
    cmd = { 'Telescope' },
    -- Set the keymaps to setup lazy loading
    setup = function()
        local get_buffer_dir = function()
            return vim.fn.expand '%:p:h'
        end

        require('which-key').register({
            ['<leader>'] = {
                function()
                    if vim.fn.isdirectory(vim.fn.getcwd() .. '/.git') == 1 then
                        require('telescope.builtin').git_files({
                            show_untracked = true
                        })
                    else
                        require('telescope.builtin').find_files({
                            hidden = true
                        })
                    end
                end,
                'Find a file in CWD',
            },
            ['/'] = {
                function()
                    require('telescope.builtin').live_grep()
                end,
                'Find a string in CWD',
            },
            s = {
                s = {
                    function()
                        require('telescope.builtin').current_buffer_fuzzy_find()
                    end,
                    'Find string in buffer',
                },
                ['/'] = {
                    function()
                        require('telescope.builtin').live_grep {
                            cwd = get_buffer_dir(),
                        }
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
    requires = {
        -- Use fzf algorithm for sorting
        {
            'nvim-telescope/telescope-fzf-native.nvim',
            run = 'make',
            after = 'telescope.nvim',
            config = function()
                require('telescope').load_extension 'fzf'
            end,
        },
    },
    config = function()
        -- Setup is required
        require('telescope').setup {
            defaults = {
                -- When running in a GUI, give some transparency to telescope window
                winblend = 30
            }
        }
    end,
}
