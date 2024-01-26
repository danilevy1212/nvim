-- Visualizes the undo history and makes it easy to browse and switch between different undo branches.

---@type LazyPluginSpec
local M = {
    'mbbill/undotree',
    cmd = { 'UndotreeToggle' },
    keys = {
        {
            '<leader>bu',
            '<Cmd>UndotreeToggle<CR>',
            desc = 'Toggle undotree',
        },
    },
    config = function()
        local g = vim.g
        g.undotree_WindowLayout = 2
        g.undotree_SetFocusWhenToggle = 1
        g.undotree_SplitWidth = 25
        g.undotree_ShortIndicators = 1
    end,
}

return M
