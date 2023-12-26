--- Clipboard operations
local M = {}

--- Sets clipboard to a string value, announcing it on the echo line.
--- @param value string
function M.set_clipboard(value)
    vim.fn.setreg('+', value)
    vim.cmd { cmd = 'echo', args = { '\'Copied to clipboard: "' .. value .. '"\'' } }
end

return M
