-- Category: completion

return {
    'nvim-telescope/telescope.nvim',
    module = 'telescope',
    -- Set the keymaps to setup lazy loading
    setup = function()
        vim.keymap.set('n', '<leader><leader>', function()
            require('telescope.builtin').find_files()
        end, { desc = 'Find a file in CWD' })

        vim.keymap.set('n', '<leader>/', function()
            require('telescope.builtin').live_grep()
        end, { desc = 'Find a instance of string in CWD' })

        vim.keymap.set('n', '<leader>ss', function()
            require('telescope.builtin').current_buffer_fuzzy_find()
        end, { desc = 'Search in buffer' })

        vim.keymap.set('n', '<leader>bb', function()
            require('telescope.builtin').buffers()
        end, { desc = 'Find live buffers' })

        vim.keymap.set('n', '<leader>ht', function()
            require('telescope.builtin').help_tags()
        end, { desc = 'Find tag help' })

        vim.keymap.set('n', '<leader>ho', function()
            require('telescope.builtin').vim_options()
        end, { desc = 'Find neovim option' })

        vim.keymap.set('n', '<leader>fr', function()
            require('telescope.builtin').oldfiles()
        end, { desc = 'Find a previously opened file' })
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
}
