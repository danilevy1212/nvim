-- Automatically set current working directory to project directory.

---@type LazyPluginSpec
local M = {
    dependencies = {
        'nvim-lua/plenary.nvim',
        'nvim-telescope/telescope.nvim',
    },
    'DrKJeff16/project.nvim',
    cmd = {
        'ProjectTelescope'
    },
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
