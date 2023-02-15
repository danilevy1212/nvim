--- Category: Organization

return {
    'akinsho/toggleterm.nvim',
    tag = '*',
    cmd = { 'ToggleTerm', 'TermExec', 'ToggleTermToggleAll' },
    setup = function()
        require('which-key').register({
            t = {
                function()
                    vim.cmd 'ToggleTerm'
                end,
                'Toggle most recently used terminal',
            },
            a = {
                function()
                    vim.cmd 'ToggleTermToggleAll'
                end,
                'Toggle all terminals',
            },
            v = {
                function()
                    vim.cmd 'ToggleTerm direction=vertical'
                end,
                'Toggle vertical terminal',
            },
            h = {
                function()
                    vim.cmd 'ToggleTerm direction=horizontal'
                end,
                'Toggle horizontal terminal',
            },
            T = {
                function()
                    vim.cmd 'ToggleTerm direction=tab'
                end,
                'Toggle new-tab terminal',
            },
        }, {
            prefix = '<leader>ot',
        })
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
            persist_size = false,
            persist_mode = false,
            shade_terminals = false,
        }
    end,
}
