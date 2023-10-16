-- A fancy, configurable, notification manager for Neovim

return {
    'rcarriga/nvim-notify',
    lazy = false,
    config = function()
        require('notify').setup {
            stages = 'fade_in_slide_out',
            fps = 60,
            timeout = 1000,
        }
        vim.notify = require 'notify'
    end,
}
