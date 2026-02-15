local on_attach = require('dan.lib.lsp').on_attach
local capabilities = require('dan.lib.lsp').get_default_capabilities()

-- Find the wrapped clangd from clang-tools in nix store
local function find_wrapped_clangd()
    local handle = io.popen("nix-build --no-out-link '<nixpkgs>' -A clang-tools 2>/dev/null")
    if handle then
        local result = handle:read("*a")
        handle:close()
        if result and result ~= "" then
            return result:gsub("%s+", "") .. "/bin/clangd"
        end
    end
    return "clangd"  -- fallback to PATH
end

-- Setup clangd using wrapped version from clang-tools
require('dan.lib.lsp').setup_lsp_server('clangd', {
    on_attach = on_attach,
    capabilities = capabilities,
    cmd = {
        find_wrapped_clangd(),
        '--background-index',
        '--clang-tidy',
        '--header-insertion=iwyu',
        '--completion-style=detailed',
        '--function-arg-placeholders=1',
        '--header-insertion-decorators',
    },
})

-- Setup DAP for C (only codelldb needs Mason)
require('dan.lib.mason').ensure_installed({ 'codelldb' }, function()

    -- Setup DAP for C
    require('dap').adapters.codelldb = {
        type = 'server',
        port = '${port}',
        executable = {
            command = vim.fn.stdpath 'data' .. '/mason/bin/codelldb',
            args = { '--port', '${port}' },
        },
    }

    require('dap').configurations.c = {
        {
            name = 'Launch file',
            type = 'codelldb',
            request = 'launch',
            program = function()
                return coroutine.create(function(dap_run_co)
                    vim.ui.input({ prompt = 'Path to executable: ', default = vim.fn.getcwd() .. '/' }, function(input)
                        coroutine.resume(dap_run_co, input)
                    end)
                end)
            end,
            cwd = '${workspaceFolder}',
            stopOnEntry = false,
        },
    }
end)
