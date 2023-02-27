-- Remove trailing comment when pressing `o` or `O`
vim.opt_local.formatoptions:remove 'o'

require('config.utils').prequire 'config.filetype.lua'
