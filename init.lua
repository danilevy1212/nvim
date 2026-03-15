-- Activate lua bytecode loader
vim.loader.enable()

-- Global constants, useful for configuration
-- TODO: consider making this a local table
CONSTANTS = {
    AUGROUP_PREFIX = 'custom_daniel_commands:',
}

-- Load the configuration
require 'dan'
