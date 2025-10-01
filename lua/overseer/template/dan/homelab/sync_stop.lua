---@diagnostic disable: missing-fields

local this_dir = debug.getinfo(1, 'S').source:sub(2):match '(.*/)'
local STOP_SESSION = this_dir .. 'sync_stop.sh'

---@type overseer.Task
return {
    name = '(Services) Stop syncing local folder with deployment remote',
    builder = function()
        return {
            cmd = STOP_SESSION,
            components = {
                'default',
                'on_complete_notify',
            },
        }
    end,
    condition = {
        callback = function()
            return require('dan.lib.os').has_exe 'mutagen'
        end,
    },
}
