-- JS / TS plugin configuration

---@type LazyPluginSpec
local M = {
    'dan/js_ts',
    ft = { 'javascript', 'javascriptreact', 'typescript', 'typescriptreact' },
    dependencies = {
        --- Translates errors from the `tsserver` LSP server into a more human-readable format
        {
            'dmmulroy/ts-error-translator.nvim',
            opts = {},
        },
    },
}

return M
