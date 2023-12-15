local api = vim.api
local create_autocmd = api.nvim_create_autocmd

local group = api.nvim_create_augroup(CONSTANTS.AUGROUP_PREFIX .. 'Terminal', {
    clear = false,
})

--- Remove line number column in terminal buffers
create_autocmd('TermOpen', {
    group = group,
    callback = function()
        vim.opt_local.number = false
        vim.opt_local.relativenumber = false
    end,
})

--- `Enter insert` mode when switching to terminal
create_autocmd('TermOpen', {
    group = group,
    command = 'startinsert',
})

--- Turn off spell checking in the terminal
create_autocmd('TermOpen', {
    group = group,
    command = 'setlocal nospell',
})
