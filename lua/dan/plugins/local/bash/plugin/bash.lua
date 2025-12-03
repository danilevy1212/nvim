local MASON_PKGS_DIR = vim.fn.stdpath 'data' .. '/mason/packages/'
local BASHDB_DIR = MASON_PKGS_DIR .. 'bash-debug-adapter/extension/bashdb_dir'

require('dan.lib.mason').ensure_installed({
    'bash-debug-adapter',
    'bash-language-server',
}, function()
    local on_attach = require('dan.lib.lsp').on_attach
    local capabilities = require('dan.lib.lsp').get_default_capabilities()

    require('dan.lib.lsp').setup_lsp_server('bashls', {
        on_attach = on_attach,
        capabilities = capabilities,
    })

    require('dap').adapters.bashdb = {
        type = 'executable',
        command = MASON_PKGS_DIR .. 'bash-debug-adapter/bash-debug-adapter',
        name = 'bashdb',
    }

    require('dap').configurations.sh = {
        {
            name = 'Launch Bash Debugger on current file',
            type = 'bashdb',
            request = 'launch',
            program = '${file}',
            cwd = '${workspaceFolder}',
            args = function()
                return coroutine.create(function(dap_run_co)
                    vim.ui.input({ prompt = 'Args (space-separated, empty for none): ' }, function(a)
                        if a == '' or not a then
                            coroutine.resume(dap_run_co, {})
                        else
                            coroutine.resume(dap_run_co, vim.split(a, '%s+'))
                        end
                    end)
                end)
            end,
            pathBashdb = BASHDB_DIR .. '/bashdb',
            pathBashdbLib = BASHDB_DIR,
            pathBash = 'bash',
            pathCat = 'cat',
            pathMkfifo = 'mkfifo',
            pathPkill = 'pkill',
            env = {},
            -- showDebugOutput = true,
            -- trace = true,
        },
    }
end)
