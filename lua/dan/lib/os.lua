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

--- Check if the current OS is MacOS
---@return boolean
function M.is_macos()
    return vim.uv.os_uname().sysname == "Darwin"
end

return M
