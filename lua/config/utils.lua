local M = {}

--- Default lsp capabilities
M.capabilities = require('cmp_nvim_lsp').default_capabilities(vim.lsp.protocol.make_client_capabilities())

--- Require without throwing an error, but notify in case of an error.
--- Meant to be used to run 'one-shot' configuration scripts.
--- See https://www.lua.org/manual/5.1/manual.html#pdf-require
--- @param modname string
--- @return boolean, unknown|nil
function M.prequire(modname)
    local ok, package_maybe = pcall(require, modname)

    if not ok then
        vim.notify(
            'Module ' .. modname .. ' fail to load, please check it:\n\n' .. tostring(package_maybe),
            vim.log.levels.ERROR,
            {
                title = 'Module ' .. modname .. ' failed to load',
            }
        )
    end

    return ok, package_maybe
end

--- Toggle a buffer modifiability
--- @return nil
function M.toggle_buffer_modifiable()
    vim.opt_local.modifiable = not vim.opt_local.modifiable:get()

    vim.notify(
        --- @diagnostic disable-next-line:param-type-mismatch
        'Toggled buffer: ' .. (vim.opt_local.modifiable:get() and 'modifiable' or 'read-only'),
        vim.log.levels.INFO,
        {
            title = 'Modifiability toggled',
        }
    )
end

--- Sets clipboard to a string value, announcing it on the echo line.
--- @param value string
function M.set_clipboard(value)
    vim.fn.setreg('+', value)
    vim.cmd { cmd = 'echo', args = { '\'Copied to clipboard: "' .. value .. '"\'' } }
end

--- Default attach function for most servers See `:h lsp_config`, on_attach
---@param _ any
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
        ['<C-k>'] = { vim.lsp.buf.signature_help, 'Signature Help' },
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
    }, { buffer = bufnr, mode = { 'n', 'v' } })
end

return M
