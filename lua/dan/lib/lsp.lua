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
    require('which-key').add {
        { 'gi', vim.lsp.buf.implementation, desc = 'Go to implementation', buffer = bufnr, mode = { 'n', 'v' } },
        { 'gR', vim.lsp.buf.references, desc = 'Find references', buffer = bufnr, mode = { 'n', 'v' } },
        { 'K', vim.lsp.buf.hover, desc = 'Hover', buffer = bufnr, mode = { 'n', 'v' } },
        {
            '<C-w>d',
            vim.diagnostic.open_float,
            desc = 'Show line diagnostic\'s information',
            buffer = bufnr,
            mode = { 'n', 'v' },
        },
        {
            '<C-w><C-d>',
            vim.diagnostic.open_float,
            desc = 'Show line diagnostic\'s information',
            buffer = bufnr,
            mode = { 'n', 'v' },
        },
        { '<leader>cd', vim.lsp.buf.definition, desc = 'Go to definition', buffer = bufnr, mode = { 'n', 'v' } },
        {
            '<leader>ct',
            vim.lsp.buf.type_definition,
            desc = 'Go to type definition',
            buffer = bufnr,
            mode = { 'n', 'v' },
        },
        { '<leader>cr', vim.lsp.buf.rename, desc = 'Rename at point', buffer = bufnr, mode = { 'n', 'v' } },
        { '<leader>cR', vim.lsp.buf.references, desc = 'Find references', buffer = bufnr, mode = { 'n', 'v' } },
        { '<leader>ca', vim.lsp.buf.code_action, desc = 'Code action', buffer = bufnr, mode = { 'n', 'v' } },
        { '<leader>cw', group = 'Workspace', buffer = bufnr, mode = { 'n', 'v' } },
        {
            '<leader>cwa',
            vim.lsp.buf.add_workspace_folder,
            desc = 'Add workspace',
            buffer = bufnr,
            mode = { 'n', 'v' },
        },
        {
            '<leader>cwr',
            vim.lsp.buf.remove_workspace_folder,
            desc = 'Remove workspace',
            buffer = bufnr,
            mode = { 'n', 'v' },
        },
        {
            '<leader>cwl',
            function()
                print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
            end,
            desc = 'List workspaces',
            buffer = bufnr,
            mode = { 'n', 'v' },
        },
    }
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
