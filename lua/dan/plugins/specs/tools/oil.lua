-- A vim-vinegar like file explorer that lets you edit your filesystem like a normal Neovim buffer.

---@type LazyPluginSpec
local M = {
    'stevearc/oil.nvim',
    -- HACK  Lazy load
    init = function(plugin)
        -- Disable netrw
        vim.g.loaded_netrw = 1
        vim.g.loaded_netrwPlugin = 1
        vim.g.loaded_netrwSettings = 1
        vim.g.loaded_netrwFileHandlers = 1
        if vim.fn.argc() == 1 then
            local argv = tostring(vim.fn.argv(0))
            local stat = vim.loop.fs_stat(argv)

            local remote_dir_args = vim.startswith(argv, 'ssh')
                or vim.startswith(argv, 'sftp')
                or vim.startswith(argv, 'scp')

            if stat and stat.type == 'directory' or remote_dir_args then
                require('lazy').load { plugins = { plugin.name } }
            end
        end
        if not require('lazy.core.config').plugins[plugin.name]._.loaded then
            vim.api.nvim_create_autocmd('BufNew', {
                callback = function()
                    if vim.fn.isdirectory(vim.fn.expand '<afile>') == 1 then
                        require('lazy').load { plugins = { 'oil.nvim' } }
                        -- Once oil is loaded, we can delete this autocmd
                        return true
                    end
                end,
            })
        end
    end,
    cmd = 'Oil',
    keys = {
        {
            '<leader>o-',
            '<Cmd>Oil<cr>',
            mode = 'n',
            desc = 'Open file directory',
        },
    },
    opts = {
        columns = {
            'icon',
            'permissions',
            'size',
            'mtime',
        },
        experimental_watch_for_changes = true,
        adapter_aliases = {
            ['ssh://'] = 'oil-ssh://',
            ['scp://'] = 'oil-ssh://',
            ['sftp://'] = 'oil-ssh://',
        },
        view_options = {
            show_hidden = true,
        },
    },
    -- Optional dependencies
    dependencies = { 'nvim-tree/nvim-web-devicons' },
}

return M
