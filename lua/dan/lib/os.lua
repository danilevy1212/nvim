local M = {}

--- Check if the current OS is NixOS
---@return boolean
function M.is_nixos()
    local os_release = vim.uv.os_uname().version
    local distro = vim.split(os_release, ' ', {
        trimempty = true,
    })[1]

    return string.find(string.lower(distro), 'nixos') ~= nil
end

--- Check if system has access to a particular executable
---@param cmd string
---@return boolean
function M.has_exe(cmd)
    return vim.fn.executable(cmd) == 1
end

--- Check if the current machine is the workstation
---@return boolean true if hostname matches "thinkpadP14s", false otherwise
function M.is_workstation()
    return vim.uv.os_gethostname() == 'thinkpadP14s'
end

return M
