-- Toggle fold with `Tab`
vim.keymap.set({ 'n', 'v', 'x' }, '<Tab>', '=', {
    buffer = true,
    remap = true,
    desc = 'Toggle fold',
})
