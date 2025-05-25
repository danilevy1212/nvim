-- A modern go neovim plugin based on treesitter, nvim-lsp and dap debugger.

--- @type LazyPluginSpec
local M = {
    'ray-x/go.nvim',
    ft = { 'go', 'gomod' },
    cond = function()
        return vim.fn.executable 'go' == 1
    end,
    dependencies = {
        'ray-x/guihua.lua',
        'neovim/nvim-lspconfig',
        'nvim-treesitter/nvim-treesitter',
        'L3MON4D3/LuaSnip',
    },
    build = function()
        require('go.install').update_all()
    end,
    config = function()
        require('dan.lib.mason').ensure_installed({ 'golangci-lint-langserver' }, function()
            vim.lsp.enable 'golangci_lint_ls'
        end)

        local capabilities = require('dan.lib.lsp').get_default_capabilities()
        local on_attach = require('dan.lib.lsp').on_attach

        require('go').setup {
            lsp_cfg = {
                capabilities = capabilities,
            },
            lsp_inlay_hints = {
                enable = true,
            },
            lsp_on_attach = on_attach,
            luasnip = true,
            dap_debug = false,
        }

        require('dap').adapters.delve = {
            type = 'server',
            port = '${port}',
            executable = {
                command = 'dlv',
                args = { 'dap', '-l', '127.0.0.1:${port}' },
            },
        }
        -- https://github.com/go-delve/delve/blob/master/Documentation/usage/dlv_dap.md
        require('dap').configurations.go = {
            {
                type = 'delve',
                name = 'Debug',
                request = 'launch',
                program = '${file}',
            },
            {
                type = 'delve',
                name = 'Debug test', -- configuration for debugging test files
                request = 'launch',
                mode = 'test',
                program = '${file}',
            },
            -- works with go.mod packages and sub packages
            {
                type = 'delve',
                name = 'Debug test (go.mod)',
                request = 'launch',
                mode = 'test',
                program = './${relativeFileDirname}',
            },
        }
    end,
}

return M
