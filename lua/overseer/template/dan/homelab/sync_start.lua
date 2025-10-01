---@diagnostic disable: missing-fields

local this_dir = debug.getinfo(1, 'S').source:sub(2):match '(.*/)'
local CREATE_SESSION = this_dir .. 'sync_start.sh'

---@type overseer.Task
return {
    name = '(Services) Sync local folder with deployment remote',
    builder = function()
        return {
            cmd = CREATE_SESSION,
            components = {
                'default',
                'on_complete_notify',
                { 'open_output', direction = 'tab' },
            },
        }
    end,
    condition = {
        callback = function()
            return require('dan.lib.os').has_exe 'mutagen'
        end,
    },
}
