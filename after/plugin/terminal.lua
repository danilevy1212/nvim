local api = vim.api
local create_autocmd = api.nvim_create_autocmd

local group = api.nvim_create_augroup(CONSTANTS.AUGROUP_PREFIX .. 'Terminal', {})

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

--- Make `gf` open a file in another window when used in terminal
create_autocmd('TermOpen', {
    group = group,
    callback = function()
        require('which-key').add({
            {
                'gf',
                function()
                    local file = vim.fn.expand '<cfile>'
                    local word = vim.fn.expand '<cWORD>'
                    local f = vim.fn.findfile(file)
                    local num = string.match(word, ':(%d*)')
                    if vim.fn.filereadable(f) == 1 then
                        vim.cmd 'wincmd p'
                        vim.cmd('e ' .. f)
                        if num ~= nil then
                            vim.cmd(num)
                            local col = string.match(word, ':%d*:(%d*)')
                            if col ~= nil then
                                vim.cmd('normal! ' .. col .. '|')
                            end
                        end
                    end
                end,
                desc = 'Open file under cursor in new window',
                mode = 'n',
            },
        }, { buffer = true })
    end,
})
