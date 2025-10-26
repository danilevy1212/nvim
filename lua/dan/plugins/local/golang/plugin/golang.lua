require('dan.lib.mason').ensure_installed(
    { 'golangci-lint-langserver', 'golangci-lint', 'gopls', 'delve', 'gofumpt', 'goimports' },
    function()
        local on_attach = require('dan.lib.lsp').on_attach
        local capabilities = require('dan.lib.lsp').get_default_capabilities()

        ---@class ServerSetup
        ---@field server_name string
        ---@field opts table

        ---@type ServerSetup[]
        local setups = {
            {
                server_name = 'gopls',
                opts = {
                    on_attach = on_attach,
                    capabilities = capabilities,
                    settings = {
                        gopls = {
                            gofumpt = true,
                            hints = {
                                assignVariableTypes = true,
                                compositeLiteralFields = true,
                                compositeLiteralTypes = true,
                                constantValues = true,
                                functionTypeParameters = true,
                                parameterNames = true,
                                rangeVariableTypes = true,
                                ignoredError = true,
                            },
                            usePlaceholders = true,
                            completeUnimported = true,
                            staticcheck = true,
                            directoryFilters = { '-.git', '-.vscode', '-.idea', '-.vscode-test', '-node_modules' },
                            semanticTokens = true,
                        },
                    },
                },
            },
            {
                server_name = 'golangci_lint_ls',
                opts = {
                    on_attach = on_attach,
                    capabilities = capabilities,
                    settings = {
                        golangci_lint_ls = {
                            settings = {
                                golangci_lint = {
                                    --Use Defaults
                                },
                            },
                        },
                    },
                },
            },
        }

        -- Conform settings for Go formatting
        require('conform').formatters_by_ft = vim.tbl_extend('force', require('conform').formatters_by_ft, {
            go = { 'goimports', 'gofmt' },
            gomod = { 'gofmt' },
        })

        -- Setup LSP servers
        for _, server_configuration in ipairs(setups) do
            require('dan.lib.lsp').setup_lsp_server(server_configuration.server_name, server_configuration.opts)
        end

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
                    return coroutine.create(function(dap_run_co)
                        local results = {}
                        local seen = {}
                        vim.fn.jobstart({
                            'rg',
                            '--type',
                            'go',
                            '--no-messages',
                            '-l',
                            '^package main',
                            '.',
                        }, {
                            stdout_buffered = false,
                            on_stdout = function(_, data)
                                if data then
                                    for _, file in ipairs(data) do
                                        if file ~= '' then
                                            local dir = vim.fn.fnamemodify(file, ':h')
                                            if not seen[dir] then
                                                seen[dir] = true
                                                table.insert(results, dir)
                                            end
                                        end
                                    end
                                end
                            end,
                            on_exit = function()
                                table.sort(results)
                                if #results == 0 then
                                    vim.notify('No Go main packages found', vim.log.levels.ERROR)
                                    coroutine.resume(dap_run_co, nil)
                                    return
                                end
                                vim.ui.select(results, {
                                    prompt = 'Select Go main package directory:',
                                }, function(choice)
                                    coroutine.resume(dap_run_co, choice)
                                end)
                            end,
                        })
                    end)
                end,
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
                program = '${fileDirname}',
                args = function()
                    return coroutine.create(function(dap_run_co)
                        vim.ui.input({ prompt = '-test.run (regex, empty for all): ' }, function(run)
                            if run == '' or not run then
                                coroutine.resume(dap_run_co, {})
                            else
                                coroutine.resume(dap_run_co, { '-test.run', run })
                            end
                        end)
                    end)
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
    end
)
