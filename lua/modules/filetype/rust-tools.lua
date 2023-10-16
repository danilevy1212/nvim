--- Category: FileType

return {
    'simrat39/rust-tools.nvim',
    -- TODO Move `config.filetype`
    ft = { 'rust' },
    config = function()
        local rt = require 'rust-tools'
        local codelldb_package_name = 'codelldb'
        local is_ok, lldb = pcall(require('mason-registry').get_package, 'codelldb')
        local extension_path = ''
        local codelldb_path = ''
        local liblldb_path = ''

        if is_ok then
            if not lldb:is_installed() then
                lldb:install()
            end
            extension_path = lldb:get_install_path() .. '/extension'
            codelldb_path = extension_path .. '/adapter/codelldb'
            liblldb_path = extension_path .. '/lldb/lib/liblldb.so'
        else
            vim.notify(
                'Debugger package '
                    .. codelldb_package_name
                    .. ' could not be found in path '
                    .. codelldb_path
                    .. '. Debugging will not work',
                vim.log.levels.ERROR {
                    title = 'Unknown package ' .. codelldb_package_name,
                }
            )
        end

        rt.setup {
            server = {
                on_attach = require('config.utils').on_attach,
                capabilities = require('cmp_nvim_lsp').default_capabilities(),
                settings = {
                    ['rust-analyzer'] = {
                        checkOnSave = {
                            command = 'clippy',
                        },
                        imports = {
                            granularity = {
                                group = 'module',
                            },
                            prefix = 'self',
                        },
                        cargo = {
                            buildScripts = {
                                enable = true,
                            },
                        },
                        procMacro = {
                            enable = true,
                        },
                    },
                },
            },
            dap = {
                adapter = vim.tbl_extend(
                    'force',
                    require('rust-tools.dap').get_codelldb_adapter(codelldb_path, liblldb_path),
                    {
                        -- NOTE  For debugging the adapter
                        -- trace = 'verboser',
                    }
                ),
            },
        }
    end,
}
