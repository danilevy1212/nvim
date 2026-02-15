require('dan.lib.mason').ensure_installed({ 'jdtls', 'java-debug-adapter' }, function()
    local jdtls = require 'jdtls'

    -- Paths
    local java_debug_adapter_path = vim.fn.stdpath 'data' .. '/mason/packages/java-debug-adapter'

    -- Debug adapter bundle
    local bundles = {
        vim.fn.glob(java_debug_adapter_path .. '/extension/server/com.microsoft.java.debug.plugin-*.jar', true),
    }

    -- LSP setup
    local on_attach = function(client, bufnr)
        require('dan.lib.lsp').on_attach(client, bufnr)

        -- Setup DAP integration with explicit java executable
        local java_exec = vim.env.JAVA_HOME and (vim.env.JAVA_HOME .. '/bin/java') or 'java'
        jdtls.setup_dap {
            hotcodereplace = 'auto',
            config_overrides = {
                javaExec = java_exec,
            },
        }

        -- Ensure DAP configurations exist
        local dap = require 'dap'
        if not dap.configurations.java then
            -- Add attach configuration for connecting to running debug server
            dap.configurations.java = {
                {
                    type = 'java',
                    request = 'attach',
                    name = 'Attach to Remote (custom port)',
                    hostName = function()
                        return vim.fn.input('Host [localhost]: ', 'localhost')
                    end,
                    port = function()
                        return tonumber(vim.fn.input('Port [5005]: ', '5005'))
                    end,
                },
                {
                    type = 'java',
                    request = 'attach',
                    name = 'Attach to Remote (localhost:5005)',
                    hostName = 'localhost',
                    port = 5005,
                },
            }
        end
    end

    local capabilities = require('dan.lib.lsp').get_default_capabilities()

    -- Find project root
    local root_dir = jdtls.setup.find_root { '.git', 'mvnw', 'gradlew', 'pom.xml', 'build.gradle' }

    -- Workspace directory in project
    local workspace_dir = root_dir .. '/.jdtls'

    -- JDTLS configuration
    local config = {
        cmd = { 'jdtls', '-data', workspace_dir },
        root_dir = root_dir,
        settings = {
            java = {
                signatureHelp = { enabled = true },
                contentProvider = { preferred = 'fernflower' },
            },
        },
        on_attach = on_attach,
        capabilities = capabilities,
        init_options = {
            bundles = bundles,
        },
    }

    -- Start JDTLS
    vim.lsp.enable 'jdtls'
    jdtls.start_or_attach(config)
end)
