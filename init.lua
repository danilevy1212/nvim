-- Activate lua bytecode loader
vim.loader.enable()

-- Global constants, useful for configuration
CONSTANTS = {
    AUGROUP_PREFIX = 'custom_daniel_commands:',
}

-- Load all plugins
require 'modules'

-- Load all options and customizations
require 'config'
