local M = {}

--- Check if the current OS is NixOS
---@return boolean
function M.is_nixos()
    local os_release = vim.trim(vim.fn.system 'grep "^ID=" /etc/os-release | cut -d= -f2')
    return os_release == 'nixos'
end

--- Check if system has access to a particular executable
---@param cmd string
---@return boolean
function M.has_exe(cmd)
    return vim.fn.executable(cmd) == 1
end

return M
