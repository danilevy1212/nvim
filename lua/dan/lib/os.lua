local M = {}

--- Check if the current OS is NixOS
---@return boolean
function M.is_nixos()
    local os_release = vim.trim(vim.fn.system 'grep "^ID=" /etc/os-release | cut -d= -f2')
    return os_release == 'nixos'
end

return M
