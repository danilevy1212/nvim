--  Automatically disables certain features if the opened file is big. File size and features to disable are configurable.

---@type LazyPluginSpec
local M = {
    'LunarVim/bigfile.nvim',
    event = { 'BufReadPre' },
    config = function()
        local api = vim.api

        ---@type featureOpts
        local rainbow_delimiters = {
            name = 'rainbow-delimiters',
            opts = {
                defer = true,
            },
            disable = function()
                local rainbow_delimiters = require 'rainbow-delimiters'

                if rainbow_delimiters.is_enabled(0) then
                    rainbow_delimiters.disable(0)
                end
            end,
        }

        ---@type featureOpts
        local spell = {
            name = 'spell',
            opts = {
                defer = true,
            },
            disable = function()
                vim.opt_local.spell = false
            end,
        }

        local features = {
            'indent_blankline',
            'lsp',
            'treesitter',
            'syntax',
            'matchparen',
            'vimopts',
            'filetype',
            rainbow_delimiters,
            spell
        }

        require('bigfile').setup {
            filesize = 2,
            pattern = { '*' },
            features = features,
        }

        api.nvim_create_user_command('BigFileEnable', function()
            local bufnr = api.nvim_get_current_buf()
            api.nvim_buf_set_var(bufnr, 'bigfile_detected', 1)

            for _, raw_feature in ipairs(features) do
                --- HACK This is a hack to disable lsp for big files
                if raw_feature == 'lsp' then
                    vim.schedule(function()
                        for _, client in ipairs(vim.lsp.get_active_clients { bufnr = bufnr }) do
                            vim.lsp.buf_detach_client(bufnr, client.id)
                        end
                    end)

                    goto continue
                end

                local feature = require('bigfile.features').get_feature(raw_feature)
                feature.disable(bufnr)
                ::continue::
            end
        end, {
            desc = 'Disable slow features for big files',
        })
    end,
}

return M
