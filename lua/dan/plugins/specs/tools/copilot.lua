-- This plugin is the pure lua replacement for github/copilot.vim.

---@type LazyPluginSpec
local COPILOT_CHAT = {
    'CopilotC-Nvim/CopilotChat.nvim',
    version = '*',
    init = function()
        require('which-key').register({}, {
            mode = 'n',
            prefix = '<leader>oc',
            desc = 'CopilotChat',
        })
    end,
    dependencies = {
        { 'nvim-lua/plenary.nvim' },
        { 'hrsh7th/nvim-cmp' },
    },
    config = function()
        require('CopilotChat').setup {
            show_help = true,
            -- Log in ~/.local/state/nvim/CopilotChat.nvim.log
            debug = true,
            -- cmp integration
            chat_autocomplete = true,
        }
    end,
    keys = {
        {
            '<leader>oce',
            '<cmd>CopilotChatExplain<cr>',
            desc = 'Explain code',
        },
        {
            '<leader>oct',
            '<cmd>CopilotChatTests<cr>',
            desc = 'Generate tests',
        },
        {
            '<leader>ocT',
            '<cmd>CopilotChatVsplitToggle<cr>',
            desc = 'Toggle Vsplit',
        },
        {
            '<leader>ocv',
            ':CopilotChatVisual',
            mode = 'x',
            desc = 'Open in vertical split',
        },
        {
            '<leader>ocx',
            ':CopilotChatInPlace<cr>',
            mode = 'x',
            desc = 'Run in-place code',
        },
        {
            '<leader>ocf',
            '<cmd>CopilotChatFixDiagnostic<cr>',
            desc = 'Fix diagnostic under cursor',
        },
        {
            '<leader>ocF',
            '<cmd>CopilotChatFix<cr>',
            desc = 'Fix general issue with this file',
        },
        {
            '<leader>oco',
            '<cmd>CopilotChatOptimize<cr>',
            desc = 'Optimize the selected code to improve performance and readablilty.',
        },
        {
            '<leader>ocr',
            '<cmd>CopilotChatReset<cr>',
            desc = 'Reset chat history and clear buffer',
        },
        {
            '<leader>och',
            function()
                require('CopilotChat.code_actions').show_help_actions()
            end,
            desc = 'Help actions telescope',
        },
        {
            '<leader>ocp',
            function()
                local actions = require 'CopilotChat.actions'
                actions.pick(actions.help_actions())
            end,
            mode = 'n',
            desc = 'Help actions telescope',
        },
        {
            '<leader>ocp',
            function()
                local actions = require 'CopilotChat.actions'
                actions.pick(actions.prompt_actions {
                    selection = require('CopilotChat.select').visual,
                })
            end,
            mode = 'x',
            desc = 'Prompt actions telescope',
        },
        {
            '<leader>oci',
            function()
                local input = vim.fn.input 'Ask Copilot: '
                if input ~= '' then
                    vim.cmd('CopilotChat ' .. input)
                end
            end,
            desc = 'Ask copilot',
        },
        {
            '<leader>ocb',
            function()
                local input = vim.fn.input 'Quick Chat: '
                if input ~= '' then
                    require('CopilotChat').ask(input, { selection = require('CopilotChat.select').buffer })
                end
            end,
            desc = 'Ask copilot about current buffer',
        },
        {
            '<leader>occ',
            '<cmd>CopilotChatCommitStaged<cr>',
            desc = 'Write commit message for the change with commitizen convention, only staged changes.',
        },
    },
}

---@type LazyPluginSpec
local COPILOT = {
    'zbirenbaum/copilot.lua',
    cmd = 'Copilot',
    event = 'InsertEnter',
    dependencies = { COPILOT_CHAT },
    config = function()
        local function get_node_command()
            if require('dan.lib.os').is_nixos() then
                return '/etc/profiles/per-user/dlevym/bin/node'
            else
                --- NOTE  Use whatever node version is available in the system.
                ---       This is OK since I am unlikely to use old / deprecated node versions in non NixOS systems.
                return 'node'
            end
        end

        --- Disable copilot for `json` files, except for `package.json`, `*.config.*`, or dot files
        local function json_enabled()
            local name = vim.api.nvim_buf_get_name(0)
            return string.match(name, 'package%.json$') or string.match(name, '%.config%.') or string.match(name, '^%.')
        end

        require('copilot').setup {
            suggestion = {
                auto_trigger = false,
            },
            panel = {
                auto_refresh = true,
                layout = {
                    position = 'right',
                    ratio = 0.25,
                },
            },
            filetypes = {
                --- Enable copilot for all filetypes by default
                ['*'] = true,
                -- Disable copilot for `.env` files but not for `.envrc` files from direnv
                sh = function()
                    local file_basename = vim.fs.basename(vim.api.nvim_buf_get_name(0))
                    return file_basename == '.envrc' or not string.match(file_basename, '^%.env.*')
                end,
                --- Disable copilot for `csv` files
                csv = false,
                --- Disable copilot for any configuration files
                conf = false,
                json = json_enabled,
                jsonc = json_enabled,
            },
            copilot_node_command = get_node_command(),
        }
    end,
}

return {
    COPILOT,
    COPILOT_CHAT,
}
