--- A blazing fast and easy to configure neovim `statusline` written in Lua.

return {
    'nvim-lualine/lualine.nvim',
    dependencies = {
        'nvim-tree/nvim-web-devicons',
        'shaunsingh/nord.nvim',
    },
    event = { 'UIEnter' },
    config = function()
        local filename_component = {
            'filename',
            --- Display new file status
            newfile_status = true,
            --- Display relative path
            path = 1,
        }

        local opts = {
            options = {
                icons_enabled = true,
                theme = 'nord',
                component_separators = { left = '', right = '' },
                section_separators = { left = '', right = '' },
                disabled_filetypes = {
                    statusline = { 'dap-repl', 'dapui_scopes', 'dapui_stacks', 'dapui_watches', 'OverseerList' },
                    winbar = { 'dap-repl', 'dapui_scopes', 'dapui_stacks', 'dapui_watches', 'OverseerList' },
                },
                ignore_focus = {},
                always_divide_middle = true,
                globalstatus = false,
                refresh = {
                    statusline = 1000,
                    tabline = 1000,
                    winbar = 1000,
                },
            },
            sections = {
                lualine_a = {
                    {
                        'mode',
                        ---@param str string
                        ---@return string
                        fmt = function(str)
                            return str:sub(1, 1)
                        end,
                    },
                },
                lualine_b = { filename_component },
                lualine_c = { { 'diagnostics', sources = { 'nvim_diagnostic' } } },
                lualine_x = { 'searchcount', 'encoding', 'fileformat', 'filetype' },
                lualine_y = { 'progress' },
                lualine_z = { 'location' },
            },
            inactive_sections = {
                lualine_a = {},
                lualine_b = {},
                lualine_c = { filename_component },
                lualine_x = { 'location' },
                lualine_y = {},
                lualine_z = {},
            },
            tabline = {
                --- TODO Check this out https://github.com/nvim-lualine/lualine.nvim#disabling-lualine, maybe I can hide and unhide the `tabline` depending on if there is more than one tab or not
                lualine_a = {
                    {
                        'tabs',
                        --- Only render if there is more than one tab
                        ---@return boolean
                        cond = function()
                            return #vim.api.nvim_list_tabpages() > 1
                        end,
                        --- TODO Render the name of the current project. This can be:
                        --- Custom tab name
                        --- Name of the base directory of the project
                        ---@param _ any
                        ---@param context { tabnr: number }
                        ---@return string
                        -- fmt = function(_, context)
                        --     local current_project = vim.fn.getcwd(0, context.tabnr)
                        --     -- print(vim.inspect(context))
                        --     return vim.fn.fnamemodify(current_project, ':t')
                        -- end,
                    },
                },
            },
            winbar = {
                --- TODO Lazy load this. Only add 'aerial' when aerial is loaded
                lualine_b = { 'aerial' },
                lualine_y = { 'branch', 'diff' },
            },
            inactive_winbar = {
                lualine_y = { 'branch', 'diff' },
            },
            extensions = {
                'toggleterm',
                'fugitive',
                'aerial',
                'oil',
                'overseer',
                'mason',
                'lazy',
            },
        }

        require('lualine').setup(opts)
    end,
}
