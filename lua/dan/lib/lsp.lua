--- LSP helpers
local M = {}

--- Default lsp capabilities
--- @return table
function M.get_default_capabilities()
    return require('cmp_nvim_lsp').default_capabilities()
end

--- Default attach function for most servers See `:h lsp_config`, on_attach
---@param _ lsp.Client
---@param bufnr number
M.on_attach = function(_, bufnr)
    -- Enable completion triggered by <c-x><c-o>
    vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')

    -- Mappings.
    require('which-key').register({
        g = {
            i = { vim.lsp.buf.implementation, 'Go to implementation' },
            R = { vim.lsp.buf.references, 'Find references' },
        },
        K = { vim.lsp.buf.hover, 'Hover' },
        --- NOTE Technically, diagnostics are separate from LSP, but so far I am always using them together.
        ['<C-k>'] = { vim.diagnostic.open_float, 'Show line diagnostic\'s information' },
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

    if start and #vim.lsp.get_active_clients {
        name = server_name,
        bufnr = bufnr,
    } == 0 then
        lspconfig[server_name].launch()
    end
end

return M
