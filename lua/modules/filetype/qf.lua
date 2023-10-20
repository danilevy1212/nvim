-- A better quickfix / location list

return {
    {
        -- Allow for modifiable quickfix buffers
        'stefandtw/quickfix-reflector.vim',
        ft = 'qf',
        config = function()
            -- Make buffers not modifiable by default (<leader>bR to toggle)
            vim.g.qf_modifiable = 0
            -- Make the changes atomic in the undo systen
            vim.g.qf_join_changes = 1
        end,
    },
    {
        -- Improvements over the built-in quickfix system
        'ten3roberts/qf.nvim',
        keys = {
            {
                '<leader>cx',
                function()
                    -- Automatically populated. Open without focusing on it.
                    require('qf').toggle('l', true)
                end,
                'n',
                { desc = 'Preview diagnostics for file' },
            },
            {
                '<leader>cX',
                function()
                    -- Populate list
                    vim.diagnostic.setqflist { open = false }

                    -- Open without focusing on it.
                    require('qf').toggle('c', true)
                end,
                'n',
                { desc = 'Preview diagnostics for workspace' },
            },
            { ']q', '<Cmd>Qnext<CR>', { desc = 'Next quickfix list item, wraps' } },
            { '[q', '<Cmd>Qprev<CR>', { desc = 'Previous quickfix list item, wraps' } },
            { '[Q', '<Cmd>cfirst<CR>', { desc = 'First quickfix list item, wraps' } },
            { ']Q', '<Cmd>clast<CR>', { desc = 'Previous quickfix list item, wraps' } },
            { ']l', '<Cmd>Lnext<CR>', { desc = 'Next location list item, wraps' } },
            { '[l', '<Cmd>Lprev<CR>', { desc = 'Previous location list item, wraps' } },
            { '[L', '<Cmd>lfirst<CR>', { desc = 'First location list item, wraps' } },
            { ']L', '<Cmd>llast<CR>', { desc = 'Last location list item, wraps' } },
        },
        ft = 'qf',
        config = function()
            -- Load ':Cfilter' and ':Lfilter' commands
            vim.cmd 'packadd cfilter'

            require('qf').setup {
                -- Location list configuration
                l = {
                    -- Automatically close location/quickfix list if empty on open
                    auto_close = true,
                    -- Follow current entry, possible values: prev,next,nearest, or false to disable
                    auto_follow = 'prev',
                    -- Do not follow if entry is further away than x lines
                    auto_follow_limit = 8,
                    -- Only follow on CursorHold
                    follow_slow = true,
                    -- Automatically open list on QuickFixCmdPost
                    auto_open = true,
                    -- Auto resize and shrink location list if less than `max_height`
                    auto_resize = true,
                    -- Maximum height of location/quickfix list
                    max_height = 8,
                    -- Minimum height of location/quickfix list.
                    min_height = 5,
                    -- Open list at the very bottom of the screen, stretching the whole width.
                    wide = false,
                    -- Show line numbers in list
                    number = false,
                    -- Show relative line numbers in list
                    relativenumber = false,
                    -- Close list when window loses focus
                    unfocus_close = false,
                    -- Auto open list on window focus if it contains items
                    focus_open = false,
                },
                -- Quickfix list configuration
                c = {
                    -- Automatically close location/quickfix list if empty
                    auto_close = true,
                    -- Follow current entry, possible values: prev,next,nearest, or false to disable
                    auto_follow = 'prev',
                    -- Do not follow if entry is further away than x lines
                    auto_follow_limit = 8,
                    -- Only follow on CursorHold
                    follow_slow = true,
                    -- Automatically open list on QuickFixCmdPost
                    auto_open = true,
                    -- Auto resize and shrink location list if less than `max_height`
                    auto_resize = true,
                    -- Maximum height of location/quickfix list
                    max_height = 8,
                    -- Minimum height of location/quickfix list.
                    min_height = 5,
                    -- Open list at the very bottom of the screen, stretching the whole width.
                    wide = false,
                    -- Show line numbers in list
                    number = false,
                    -- Show relative line numbers in list
                    relativenumber = false,
                    -- Close list when window loses focus
                    unfocus_close = false,
                    -- Auto open list on window focus if it contains items
                    focus_open = false,
                },
                -- Close location list when quickfix list opens
                close_other = false,
                -- "Pretty print quickfix lists"
                pretty = true,
            }
        end,
    },
}
