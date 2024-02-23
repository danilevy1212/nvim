--- A code outline window for skimming and quick navigation

---@type LazyPluginSpec
local M = {
    'stevearc/aerial.nvim',
    -- FIX  I'm pinned to this version because I use the stable nvim-treesitter branch
    commit = '9523ebc7f0805a4d69a76ef35960a7788a4127af',
    cmd = {
        'AerialToggle',
    },
    keys = {
        { '<leader>si', '<cmd>AerialToggle<cr>', desc = 'Index' },
        {
            '<leader>sI',
            function()
                require('telescope').extensions.aerial.aerial(require('telescope.themes').get_ivy {
                    previewer = false,
                    layout_config = {
                        height = 0.3,
                    },
                })
            end,
            desc = 'Index',
        },
    },
    dependencies = {
        'nvim-treesitter/nvim-treesitter',
        'nvim-tree/nvim-web-devicons',
    },
    config = function()
        require('aerial').setup {}

        require('telescope').load_extension 'aerial'
    end,
}

return M
