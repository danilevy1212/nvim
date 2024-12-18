--- LSP helpers
local M = {}

--- Default lsp capabilities
--- @param override? table
--- @return table
function M.get_default_capabilities(override)
    return require('cmp_nvim_lsp').default_capabilities(override or {})
end

--- Default attach function for most servers See `:h lsp_config`, on_attach
---@param client { server_capabilities: lsp.ServerCapabilities }
---@param bufnr number
M.on_attach = function(client, bufnr)
    -- Enable completion triggered by <c-x><c-o>
    vim.api.nvim_set_option_value('omnifunc', 'v:lua.vim.lsp.omnifunc', {
        buf = bufnr,
    })

    --- Enable inlay hints if available
    if client.server_capabilities.inlayHintProvider then
        vim.lsp.inlay_hint.enable(true, {
            bufnr = bufnr,
        })
    end

    -- Mappings.
    require('which-key').register({
        g = {
            i = { vim.lsp.buf.implementation, 'Go to implementation' },
            R = { vim.lsp.buf.references, 'Find references' },
        },
        K = { vim.lsp.buf.hover, 'Hover' },
        ['<C-w>d'] = { vim.diagnostic.open_float, 'Show line diagnostic\'s information' },
        ['<C-w><C-d>'] = { vim.diagnostic.open_float, 'Show line diagnostic\'s information' },
        ['<leader>'] = {
            c = {
                name = 'Code',
                d = { vim.lsp.buf.definition, 'Go to definition' },
                t = { vim.lsp.buf.type_definition, 'Go to type definition' },
                r = { vim.lsp.buf.rename, 'Rename at point' },
                R = { vim.lsp.buf.references, 'Find references' },
                a = { vim.lsp.buf.code_action, 'Code action' },
                w = {
                    name = 'Workspace',
                    a = { vim.lsp.buf.add_workspace_folder, 'Add workspace' },
                    r = { vim.lsp.buf.remove_workspace_folder, 'Remove workspace' },
                    l = {
                        function()
                            print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
                        end,
                        'List workspaces',
                    },
                },
            },
        },
    }, { buffer = bufnr, mode = { 'n', 'v' } })
end

--- Sets up a specified Language Server Protocol (LSP) server using `nvim-lspconfig`, optionally starting it for a given buffer.
---@param server_name string The name of the LSP server to set up.
---@param setup_opts table Configuration options for the LSP server.
---@param start boolean? Whether to start the LSP server if it's not already active; defaults to true.
---@param bufnr number? Buffer number to associate with the LSP server; defaults to current buffer.
function M.setup_lsp_server(server_name, setup_opts, start, bufnr)
    local lspconfig = require 'lspconfig'

    if bufnr == nil then
        bufnr = vim.api.nvim_get_current_buf()
    end

    if start == nil then
        start = true
    end

    lspconfig[server_name].setup(setup_opts)

    if start and #vim.lsp.get_clients {
        name = server_name,
        bufnr = bufnr,
    } == 0 then
        lspconfig[server_name].launch()
    end
end

return M
