--- Buffer related stuff
local M = {}

--- Toggle a buffer modifiability
function M.toggle_buffer_modifiable()
    vim.opt_local.modifiable = not vim.opt_local.modifiable:get()

    vim.notify(
        --- @diagnostic disable-next-line:param-type-mismatch
        'Toggled buffer: ' .. (vim.opt_local.modifiable:get() and 'modifiable' or 'read-only'),
        vim.log.levels.INFO,
        {
            title = 'Modifiability toggled',
        }
    )
end

return M
