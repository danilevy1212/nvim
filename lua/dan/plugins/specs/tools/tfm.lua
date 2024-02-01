-- Neovim plugin for Terminal File Manager integration.

---@type LazyPluginSpec
local M = {
    'Rolv-Apneseth/tfm.nvim',
    event = {
        'BufEnter',
        'BufNewFile',
    },
    init = function()
        -- Disable netrw
        vim.g.loaded_netrw = 1
        vim.g.loaded_netrwPlugin = 1
        vim.g.loaded_netrwSettings = 1
        vim.g.loaded_netrwFileHandlers = 1
    end,
    keys = {
        {
            '<leader>o-',
            '<Cmd>Tfm<cr>',
            mode = 'n',
            desc = 'Open file directory',
        },
    },
    opts = {
        file_manager = 'yazi',
        replace_netrw = true,
        enable_cmds = true,
    },
}

return M
