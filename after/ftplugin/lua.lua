-- Remove trailing comment when pressing `o` or `O`
vim.opt_local.formatoptions:remove 'o'

-- Using 'require' will run this code as a script only once, see https://www.lua.org/manual/5.1/manual.html#pdf-require
require 'config.filetype.lua'
