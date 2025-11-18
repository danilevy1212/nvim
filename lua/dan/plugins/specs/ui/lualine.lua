--- A blazing fast and easy to configure neovim `statusline` written in Lua.

return {
    'nvim-lualine/lualine.nvim',
    dependencies = {
        'nvim-tree/nvim-web-devicons',
        'gbprod/nord.nvim',
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
                lualine_a = {
                    {
                        --- See `:h lualine-tabs-component-options`
                        'tabs',
                        --- Only render if there is more than one tab
                        ---@return boolean
                        cond = function()
                            return #vim.api.nvim_list_tabpages() > 1
                        end,
                        --- Show tab_nr + tab_name
                        mode = 3,
                        use_mode_colors = true,
                        ---@param name string
                        ---@param context any -- see `require('lualine.components.tabs')`
                        ---@return string
                        fmt = function(name, context)
                            local tab_cwd = vim.fn.getcwd(-1, context.tabnr)
                            local folder = vim.fn.fnamemodify(tab_cwd, ':t')
                            local parent = vim.fn.fnamemodify(tab_cwd, ':h')
                            local parent_folder = vim.fn.fnamemodify(parent, ':t')

                            -- Return "parent/current" or fallback
                            if parent_folder ~= '' and parent_folder ~= '.' then
                                return parent_folder .. '/' .. folder
                            elseif folder ~= '' then
                                return folder
                            else
                                return name
                            end
                        end,
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
