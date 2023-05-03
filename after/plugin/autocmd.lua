local group = vim.api.nvim_create_augroup(CONSTANTS.AUGROUP, {
    clear = false,
})

vim.api.nvim_create_autocmd('BufReadPost', {
    desc = 'Set cursor to last place it was on before exiting. Taken from `https://this-week-in-neovim.org/2023/Jan/2#tips`',
    group = group,
    callback = function()
        local mark = vim.api.nvim_buf_get_mark(0, '"')
        local lcount = vim.api.nvim_buf_line_count(0)
        if mark[1] > 0 and mark[1] <= lcount then
            pcall(vim.api.nvim_win_set_cursor, 0, mark)
        end
    end,
})

vim.api.nvim_create_autocmd('BufReadPre', {
    desc = 'Add source and code information to the vim.diagnostics virtual text. Format: message :: source :: code',
    group = group,
    callback = function()
        vim.diagnostic.config {
            virtual_text = {
                --- @param diagnostic Diagnostic
                format = function(diagnostic)
                    local extra_info = vim.tbl_filter(function(value)
                        return value ~= nil
                    end, { diagnostic.message, diagnostic.source, diagnostic.code })

                    return table.concat(extra_info, ' :: ')
                end,
            },
        }
    end,
    once = true,
})
