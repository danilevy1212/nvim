-- Automatically set current working directory to project directory.

---@type LazyPluginSpec
local M = {
    'ahmedkhalf/project.nvim',
    event = 'DirChangedPre',
    init = function()
        require('which-key').add {
            {
                '<leader>pp',
                function()
                    --- HACK Load `project_nvim` if it hasn't already, so all the projects appear
                    if not package.loaded['project_nvim'] then
                        -- Wait until the cache is hot
                        vim.fn.wait(1000, function()
                            return require('project_nvim.utils.history').recent_projects ~= nil
                        end)
                    end
                    require('telescope').extensions.projects.projects()
                end,
                desc = 'Switch project',
            },
        }
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
            -- Use the version control system and other custom patterns for detection
            patterns = { '.git', '_darcs', '.hg', '.bzr', '.svn', '.project' },
            -- Show hidden files
            show_hidden = false,
        }

        -- Telescope integration
        require('telescope').load_extension 'projects'
    end,
}

return M
