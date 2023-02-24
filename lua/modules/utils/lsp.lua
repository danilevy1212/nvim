local M = {}

--- Default attach function for most servers See `:h lsp_config`, on_attach
---@param client any
---@param bufnr number
M.on_attach = function(client, bufnr)
    -- Enable completion triggered by <c-x><c-o>
    vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')

    -- Mappings.
    require('which-key').register({
        g = {
            i = { vim.lsp.buf.implementation, 'Go to implementation' },
            R = { vim.lsp.buf.references, 'Find references' },
        },
        K = { vim.lsp.buf.hover, 'Hover' },
        ['C-k'] = { vim.lsp.buf.signature_help, 'Signature Help' },
        ['<leader>'] = {
            c = {
                name = 'Code',
                d = { vim.lsp.buf.definition, 'Go to definition' },
                f = {
                    function()
                        vim.lsp.buf.format { async = true }
                    end,
                    'Format',
                },
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
    }, { buffer = bufnr })

    local group = vim.api.nvim_create_augroup(CONSTANTS.AUGROUP, {
        clear = false,
    })

    --- Create autocmd to keep location list and quickfix list sync with diagnostics
    vim.api.nvim_create_autocmd('DiagnosticChanged', {
        group = group,
        buffer = bufnr,
        desc = 'Keep location list in sync with LSP diagnostics',
        callback = function()
            vim.diagnostic.setloclist { open = false }
        end,
    })
end

return M
