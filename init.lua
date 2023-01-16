local sysname = vim.loop.os_uname().sysname

-- Global constants, useful for configuration
_G.CONSTANTS = {
    IS_LINUX = sysname == 'Linux',
    IS_MACOS = sysname == 'Darwin',
    AUGROUP = 'custom_daniel_commands',
}

-- Load builtin options and other no-depedency customization
require 'config'

-- Load all plugins, after setting built-ins
require 'modules'
