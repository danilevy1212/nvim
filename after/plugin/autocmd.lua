local group = vim.api.nvim_create_augroup(CONSTANTS.AUGROUP, {
    clear = false,
})

-- Set cursor to last place it was on before exiting. Taken from `https://this-week-in-neovim.org/2023/Jan/2#tips`
vim.api.nvim_create_autocmd('BufReadPost', {
    group = group,
    callback = function()
        local mark = vim.api.nvim_buf_get_mark(0, '"')
        local lcount = vim.api.nvim_buf_line_count(0)
        if mark[1] > 0 and mark[1] <= lcount then
            pcall(vim.api.nvim_win_set_cursor, 0, mark)
        end
    end,
})
