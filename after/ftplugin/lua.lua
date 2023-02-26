-- Remove trailing comment when pressing `o` or `O`
vim.opt_local.formatoptions:remove 'o'

require('config.utils').require_with_warn 'config.filetype.lua'
