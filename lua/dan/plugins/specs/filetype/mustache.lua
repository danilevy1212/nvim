-- A vim plugin for working with mustache and handlebars templates.

---@type LazyPluginSpec
local M = {
    'mustache/vim-mustache-handlebars',
    init = function()
        local augroup = vim.api.nvim_create_augroup(CONSTANTS.AUGROUP_PREFIX .. 'specs:mustache', {})
        local autocmd = vim.api.nvim_create_autocmd
        local pattern = { '*.mustache', '*.handlebars', '*.hdbs', '*.hbs', '*.hb', '*.hogan', '*.hulk', '*.hjs' }

        autocmd('BufRead', {
            desc = 'Turn off tree-sitter for mustache and handlebars files',
            group = augroup,
            pattern = pattern,
            callback = function()
                vim.cmd 'TSBufDisable highlight'
            end,
        })

        autocmd('BufRead', {
            desc = 'Turn off spell checking for mustache and handlebars files',
            group = augroup,
            pattern = pattern,
            callback = function()
                vim.cmd 'setlocal nospell'
            end,
        })
    end,
    ft = { 'html.mustache', 'html.handlebars' },
}

return M
