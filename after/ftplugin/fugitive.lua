-- Toggle fold with `Tab`
vim.keymap.set({ 'n', 'v', 'x' }, '<Tab>', '=', {
    buffer = true,
    remap = true,
    desc = 'Toggle fold',
})

-- No number fringe
vim.opt_local.number = false
vim.opt_local.relativenumber = false
