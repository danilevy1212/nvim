local group = vim.api.nvim_create_augroup(CONSTANTS.AUGROUP_PREFIX .. 'Terminal', {
    clear = false,
})

-- Remove line number column in terminal buffers
vim.api.nvim_create_autocmd('TermOpen', {
    group = group,
    callback = function()
        vim.opt_local.number = false
        vim.opt_local.relativenumber = false
    end,
})

-- Enter insert mode when switching to terminal
vim.api.nvim_create_autocmd('TermOpen', {
    group = group,
    command = 'startinsert',
})
