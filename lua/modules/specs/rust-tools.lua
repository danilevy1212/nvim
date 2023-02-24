--- Category: FileType

return {
    'simrat39/rust-tools.nvim',
    ft = { 'rust' },
    config = function()
        local rt = require 'rust-tools'

        rt.setup {
            server = {
                on_attach = require('modules.utils.lsp').on_attach,
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
        }
    end,
}
