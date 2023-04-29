--- A blazing fast and easy to configure Neovim statusline written in Lua.

return {
    'nvim-lualine/lualine.nvim',
    dependencies = { 'nvim-tree/nvim-web-devicons', 'shaunsingh/nord.nvim' },
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
                    statusline = {},
                    winbar = {},
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
                lualine_a = { 'mode' },
                lualine_b = { 'branch', 'diff', { 'diagnostics', sources = { 'nvim_diagnostic' } } },
                lualine_c = {
                    filename_component,
                },
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
            tabline = {},
            winbar = {},
            inactive_winbar = {},
            extensions = {
                'toggleterm',
                'fugitive',
            },
        }

        require('lualine').setup(opts)
    end,
}
