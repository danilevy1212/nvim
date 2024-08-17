-- nvim-dap is a Debug Adapter Protocol client implementation for Neovim

---@type LazyPluginSpec
local M = {
    'mfussenegger/nvim-dap',
    dependencies = {
        -- Creates a beautiful debugger UI
        {
            'rcarriga/nvim-dap-ui',
            dependencies = {
                'nvim-neotest/nvim-nio',
            },
        },
        -- Virtual text for the debugger
        {
            'theHamsta/nvim-dap-virtual-text',
            opts = {
                all_references = true,
                clear_on_continue = true,
            },
        },
        -- Add syntax highlighting to the nvim-dap REPL buffer using treesitter.
        {
            'LiadOz/nvim-dap-repl-highlights',
            opts = {
                highlight = {
                    enable = true,
                },
                ensure_installed = { 'dap_repl' },
            },
        },
        'stevearc/overseer.nvim',
    },
    keys = {
        -- Inspired by the chrome devtools bindings
        {
            '<F7>',
            '<cmd>lua require("dapui").toggle()<CR>',
            mode = 'n',
        },
        {
            '<F8>',
            -- NOTE  See https://github.com/mfussenegger/nvim-dap/issues/20#issuecomment-1356791734
            function()
                if vim.fn.filereadable '.vscode/launch.json' == 1 then
                    require('dap.ext.vscode').load_launchjs(nil, {
                        ['pwa-node'] = {
                            'javascript',
                            'javascriptreact',
                            'typescript',
                            'typescriptreact',
                        },
                    })
                end
                require('dap').continue()
            end,
            mode = 'n',
        },
        {
            '<F9>',
            '<cmd>lua require("dap").toggle_breakpoint()<CR>',
            mode = 'n',
        },
        {
            '<S-F9>',
            '<cmd>lua require("dap").set_breakpoint(vim.fn.input("Breakpoint condition: "))<CR>',
            mode = 'n',
        },
        {
            '<F10>',
            '<cmd>lua require("dap").step_into()<CR>',
            mode = 'n',
        },
        {
            '<F11>',
            '<cmd>lua require("dap").step_over()<CR>',
            mode = 'n',
        },
        {
            '<S-F11>',
            '<cmd>lua require("dap").step_out()<CR>',
            mode = 'n',
        },
        {
            '<F12>',
            '<cmd>lua require("dap").repl.toggle()<CR>',
            mode = 'n',
        },
    },
    config = function()
        local dap = require 'dap'
        local dapui = require 'dapui'
        ---@diagnostic disable-next-line: missing-fields
        dapui.setup {
            icons = { expanded = '▾', collapsed = '▸', current_frame = '*' },
            ---@diagnostic disable-next-line: missing-fields
            controls = {
                icons = {
                    pause = '⏸',
                    play = '▶',
                    step_into = '⏎',
                    step_over = '⏭',
                    step_out = '⏮',
                    step_back = 'b',
                    run_last = '▶▶',
                    terminate = '⏹',
                    disconnect = '⏏',
                },
            },
        }
        dap.listeners.after.event_initialized['dapui_config'] = dapui.open
        dap.listeners.before.event_terminated['dapui_config'] = dapui.close
        dap.listeners.before.event_exited['dapui_config'] = dapui.close

        local sd = vim.fn.sign_define
        sd('DapBreakpoint', { text = '🛑', texthl = '', linehl = '', numhl = '' })
        sd('DapBreakpointRejected', { text = '🛑', texthl = 'Error', linehl = '', numhl = '' })

        require('dap.ext.vscode').json_decode = require('overseer.json').decode
        require('overseer').enable_dap(true)
    end,
}

return M
