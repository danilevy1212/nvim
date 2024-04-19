-- Neovim plugin to improve the default vim.ui interfaces

---@type LazyPluginSpec
local M = {
    'stevearc/dressing.nvim',
    -- NOTE  We wrap the vim.ui functions to use the dressing.nvim plugin
    init = function()
        local function wrap_vim_ui_function(function_name)
            vim.ui[function_name] = function(...)
                require 'dressing'
                vim.ui[function_name](...)
            end
        end

        for _, func in ipairs { 'select', 'input' } do
            wrap_vim_ui_function(func)
        end
    end,
    opts = {
        select = {
            backend = { 'telescope' },
        },
    },
}

return M
