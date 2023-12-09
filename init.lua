-- Activate lua bytecode loader
vim.loader.enable()

local sysname = vim.loop.os_uname().sysname

-- Global constants, useful for configuration
CONSTANTS = {
    IS_LINUX = sysname == 'Linux',
    AUGROUP_PREFIX = 'custom_daniel_commands:',
}

-- Load builtin options and other no-depedency customization
require 'config'

-- Load all plugins, after setting built-ins
require 'modules'
