--- Category: organization

-- Automatically set CWD to project directory
return {
    'ahmedkhalf/project.nvim',
    event = 'DirChangedPre',
    after = 'telescope.nvim',
    setup = function()
        vim.keymap.set('n', '<leader>pp', function()
            require('telescope').extensions.projects.projects()
        end, { desc = 'Switch to another project' })
    end,
    config = function()
        require('project_nvim').setup {
            silent_chdir = false,
            scope_chdir = 'win',
            -- Prevent 'null-ls' from setting the CWD
            ignore_lsp = { 'null-ls' },
        }

        -- Telescope integration
        require('telescope').load_extension 'projects'
    end,
}
