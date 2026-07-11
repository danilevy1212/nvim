require('dan.lib.mason').ensure_installed({ 'zls', 'codelldb' }, function()
    require('dan.lib.lsp').setup_lsp_server('zls', {
        on_attach = require('dan.lib.lsp').on_attach,
        capabilities = require('dan.lib.lsp').get_default_capabilities(),
        settings = {
            zls = {
                enable_build_on_save = true,
            },
        },
    })

    -- Setup DAP for Zig
    require('dap').adapters.codelldb = {
        type = 'server',
        port = '${port}',
        executable = {
            command = vim.fn.stdpath 'data' .. '/mason/bin/codelldb',
            args = { '--port', '${port}' },
        },
    }

    -- DAP configs
    require('dap').configurations.zig = {
        -- zig build
        -- ref: https://ziggit.dev/t/debugging-zig-with-a-debugger/7160/4
        {
            name = 'Debug default build (must be built before)',
            type = 'codelldb',
            request = 'launch',
            program = '${workspaceFolder}/zig-out/bin/${workspaceFolderBasename}',
            cwd = '${workspaceFolder}',
            args = require('dan.lib.dap').get_args_coroutine,
        },
        {
            name = 'Debug an executable (must be built before)',
            type = 'codelldb',
            request = 'launch',
            program = function()
                return coroutine.create(function(co)
                    local path_glob = vim.fn.getcwd() .. '**/zig-out/**/*'

                    vim.ui.select(vim.fn.glob(path_glob, false, true), {
                        prompt = 'Select executable',
                        kind = 'file',
                    }, function(item)
                        coroutine.resume(co, item)
                    end)
                end)
            end,
            cwd = '${workspaceFolder}',
            stopOnEntry = false,
            args = require('dan.lib.dap').get_args_coroutine,
        },
        -- See https://gist.github.com/floooh/31143278a0c0bae4f38b8722a8a98463?permalink_comment_id=5041760
        {
            name = 'Debug a test (current file)',
            type = 'codelldb',
            request = 'launch',
            program = function()
                return coroutine.create(function(co)
                    local file_no_ext = vim.fn.expand '%:t:r'
                    local relative_file = vim.fn.expand '%:.'
                    local bin_path = 'zig-out/bin/' .. file_no_ext .. '-test'

                    vim.ui.input({ prompt = 'Test filter (substring, empty for all): ' }, function(filter)
                        local cmd = {
                            'zig',
                            'test',
                            '-femit-bin=' .. bin_path,
                            '--test-no-exec',
                            relative_file,
                        }
                        if filter and filter ~= '' then
                            table.insert(cmd, '--test-filter')
                            table.insert(cmd, filter)
                        end

                        vim.fn.jobstart(cmd, {
                            cwd = vim.fn.getcwd(),
                            on_exit = function()
                                coroutine.resume(co, vim.fn.getcwd() .. '/' .. bin_path)
                            end,
                        })
                    end)
                end)
            end,
            cwd = '${workspaceFolder}',
            stopOnEntry = false,
            args = {},
        },
    }
end)
