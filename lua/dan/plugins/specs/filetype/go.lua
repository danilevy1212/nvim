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

        require('dap').adapters.delve_remote = {
            type = 'server',
            port = 40000,
        }

        -- https://github.com/go-delve/delve/blob/master/Documentation/usage/dlv_dap.md
        require('dap').configurations.go = {
            {
                name = 'Launch (ask for package or main.go)',
                type = 'delve',
                request = 'launch',
                program = function()
                    return vim.fn.input('Path to package or main.go: ', vim.fn.getcwd() .. '/', 'file')
                end,
                args = function()
                    local a = vim.fn.input 'Args (space-separated, empty for none): '
                    if a == '' then
                        return {}
                    end

                    return vim.split(a, '%s+')
                end,
                env = {
                    -- Prevent FORTIFY_SOURCE errors
                    CGO_CFLAGS = '-O2 -g',
                },
            },
            {
                name = 'Test current package',
                type = 'delve',
                request = 'launch',
                mode = 'test',
                program = './${relativeFileDirname}',
                args = function()
                    local run = vim.fn.input '-test.run (regex, empty for all): '
                    if run == '' then
                        return {}
                    end

                    return { '-test.run', run }
                end,
                env = {
                    -- Prevent FORTIFY_SOURCE errors
                    CGO_CFLAGS = '-O2 -g',
                },
            },
            -- Attach to an already running headless dlv (generic)
            {
                name = 'Attach to running dlv (host/port prompt)',
                type = 'delve_remote',
                request = 'attach',
                mode = 'remote',
            },
            {
                type = 'delve',
                name = 'Attach (local PID) (requires compilation with `go build -gcflags="all=-N -l"`)',
                mode = 'local',
                request = 'attach',
                processId = require('dap.utils').pick_process,
            },
        }
    end,
}

return M
