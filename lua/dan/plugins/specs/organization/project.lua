-- Automatically set current working directory to project directory.

---@type LazyPluginSpec
local M = {
    'DrKJeff16/project.nvim',
    event = 'DirChangedPre',
    keys = {
        {
            '<leader>pp',
            function()
                vim.cmd.ProjectTelescope()
            end,
            desc = 'Switch project',
        },
    },
    config = function()
        ---@type Project.Config.Options
        local opts = {
            -- Don't announce change in directory
            silent_chdir = true,
            -- Change directory for tab only
            scope_chdir = 'tab',
            -- Only use patterns to detect projects
            detection_methods = { 'pattern' },
            -- Use the version control system and other custom patterns for detection
            patterns = { '.git', '_darcs', '.hg', '.bzr', '.svn', '.project' },
            -- Show hidden files
            show_hidden = false,
            -- Auto detection is pretty busted, use manual adding
            manual_mode = true,
        }

        require('project').setup(opts)

        -- Telescope integration
        require('telescope').load_extension 'projects'
    end,
}

return M
