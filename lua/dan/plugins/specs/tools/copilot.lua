-- This plugin is the pure lua replacement for github/copilot.vim.

---@type LazyPluginSpec
local COPILOT = {
    'zbirenbaum/copilot.lua',
    cmd = 'Copilot',
    event = 'InsertEnter',
    config = function()
        local function is_nixos()
            local os_release = vim.trim(vim.fn.system 'grep "^ID=" /etc/os-release | cut -d= -f2')
            return os_release == 'nixos'
        end

        local function get_node_command()
            if is_nixos() then
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
                auto_trigger = true,
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

---@type LazyPluginSpec
local COPILOT_CHAT = {
    'CopilotC-Nvim/CopilotChat.nvim',
    init = function()
        require('which-key').register({}, {
            mode = 'n',
            prefix = '<leader>oc',
            desc = 'CopilotChat',
        })
    end,
    config = function()
        require('CopilotChat').setup {
            show_help = 'yes',
            -- Log in ~/.local/state/nvim/CopilotChat.nvim.log
            debug = true,
            disable_extra_info = 'no',
            language = 'English',
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
                require('CopilotChat.code_actions').show_prompt_actions()
            end,
            desc = 'Help actions telescope',
        },
        {
            '<leader>ocp',
            ':lua require(\'CopilotChat.code_actions\').show_prompt_actions(true)<CR>',
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
    },
    build = function()
        vim.cmd 'UpdateRemotePlugins'
        vim.cmd 'source $XDG_DATA_HOME/nvim/rplugin.vim'
    end,
}

return {
    COPILOT,
    COPILOT_CHAT,
}
