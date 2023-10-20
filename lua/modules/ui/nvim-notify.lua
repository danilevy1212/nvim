-- A fancy, configurable, notification manager for Neovim

return {
    'rcarriga/nvim-notify',
    lazy = false,
    keys = {
        {
            '<leader>sN',
            function()
                require('telescope').extensions.notify.notify()
            end,
            desc = 'Notifications',
        },
    },
    config = function()
        require('notify').setup {
            level = vim.log.levels.INFO,
            stages = 'fade_in_slide_out',
            fps = 60,
            timeout = 750,
        }
        vim.notify = require 'notify'
    end,
}
