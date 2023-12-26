-- A super powerful autopair plugin for Neovim that supports multiple characters.

---@type LazyPluginSpec
local M = {
    'windwp/nvim-autopairs',
    dependencies = { 'nvim-treesitter/nvim-treesitter' },
    event = { 'BufRead' },
    config = function()
        require('nvim-autopairs').setup {
            disable_filetype = { 'TelescopePrompt', 'vim' },
            disable_in_macro = false,
            check_ts = true,
        }
    end,
}

return M
