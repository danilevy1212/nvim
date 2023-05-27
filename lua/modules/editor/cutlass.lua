--- Overrides the delete operations to actually just delete and not affect the current yank.

return {
    'gbprod/cutlass.nvim',
    event = { 'BufReadPost' },
    opts = {
        --- Delete in visual mode 'cuts'
        exclude = { 'xd', 'xD'}
    },
}
