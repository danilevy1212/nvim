-- A friendlier terminal

---@type LazyPluginSpec
local M = {
    'akinsho/toggleterm.nvim',
    version = '*',
    cmd = { 'ToggleTerm', 'TermExec', 'ToggleTermToggleAll' },
    init = function()
        require('which-key').add {
            { '<leader>ot', group = 'Terminal' },
            { '<leader>ott', '<cmd>ToggleTerm<CR>', desc = 'ToggleTerm' },
            { '<leader>ota', '<cmd>ToggleTermToggleAll<CR>', desc = 'ToggleTermToggleAll' },
            { '<leader>otv', '<cmd>ToggleTerm direction=vertical<CR>', desc = 'Vertical Terminal' },
            { '<leader>oth', '<cmd>ToggleTerm direction=horizontal<CR>', desc = 'Horizontal Terminal' },
            { '<leader>otT', '<cmd>ToggleTerm direction=tab<CR>', desc = 'Tab Terminal' },
        }
    end,
    config = function()
        require('toggleterm').setup {
            size = function(term)
                if term.direction == 'horizontal' then
                    return 15
                elseif term.direction == 'vertical' then
                    return vim.o.columns * 0.33
                end
            end,
            auto_scroll = false,
            persist_size = false,
            persist_mode = false,
            shade_terminals = false,
        }
    end,
}

return M
