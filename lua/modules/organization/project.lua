-- Automatically set CWD to project directory.

return {
    'ahmedkhalf/project.nvim',
    event = 'DirChangedPre',
    init = function()
        require('which-key').register({
            p = {
                function()
                    require('telescope').extensions.projects.projects()
                end,
                'Switch project',
            },
        }, { prefix = '<leader>p' })
    end,
    config = function()
        -- See https://github.com/ahmedkhalf/project.nvim#%EF%B8%8F-configuration
        require('project_nvim').setup {
            -- Don't announce change in directory
            silent_chdir = true,
            -- Change directory for window only
            scope_chdir = 'win',
            -- Only use patterns to detect projects
            detection_methods = { 'pattern' },
            -- Use VSC and other custom patterns for detection
            patterns = { '.git', '_darcs', '.hg', '.bzr', '.svn', '.project' },
            -- Show hidden files
            show_hidden = false,
        }

        -- Telescope integration
        require('telescope').load_extension 'projects'
    end,
}
