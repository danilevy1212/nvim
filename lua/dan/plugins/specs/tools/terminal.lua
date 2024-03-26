-- A friendlier terminal

---@type LazyPluginSpec
local M = {
    'akinsho/toggleterm.nvim',
    version = '*',
    cmd = { 'ToggleTerm', 'TermExec', 'ToggleTermToggleAll' },
    keys = {
        {
            '<leader>ott',
            '<cmd>ToggleTerm<CR>',
        },
        {
            '<leader>ota',
            '<cmd>ToggleTermToggleAll<CR>',
        },
        {
            '<leader>otv',
            '<cmd>ToggleTerm direction=vertical<CR>',
        },
        {
            '<leader>oth',
            '<cmd>ToggleTerm direction=horizontal<CR>',
        },
        {
            '<leader>otT',
            '<cmd>ToggleTerm direction=tab<CR>',
        },
        {
            '<leader>ot',
            desc = 'Terminal',
        },
    },
    config = function()
        require('toggleterm').setup {
            size = function(term)
                if term.direction == 'horizontal' then
                    return 15
                elseif term.direction == 'vertical' then
                    return vim.o.columns * 0.33
                end
            end,
            shell = function()
                return 'sh -c \'NVIM_TOGGLETERM=1 ' .. vim.o.shell .. '\''
            end,
            auto_scroll = false,
            persist_size = false,
            persist_mode = false,
            shade_terminals = false,
        }
    end,
}

return M
