--- The fun starts here!

-- Keybindings
require 'config.remap'

-- Sanitized Defaults
require 'config.options'

-- GUI of choice configuration, if I am in it
if vim.g.neovide then
    require 'config.neovide'
end
