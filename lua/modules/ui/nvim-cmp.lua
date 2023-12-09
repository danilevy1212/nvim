--- The types are wrong, properties are optional in reality
---@diagnostic disable: missing-fields

-- Auto completion framework
return {
    'hrsh7th/nvim-cmp',
    event = { 'InsertEnter', 'CmdlineEnter' },
    dependencies = {
        -- Snippets
        { 'L3MON4D3/LuaSnip' },

        -- Snippet completion
        { 'saadparwaiz1/cmp_luasnip' },

        -- Cmdline completion
        { 'hrsh7th/cmp-cmdline' },

        -- Buffer words completion
        { 'hrsh7th/cmp-buffer' },

        -- Path completion
        { 'hrsh7th/cmp-path' },
    },
    config = function()
        local cmp = require 'cmp'
        local luasnip = require 'luasnip'

        --- Toggle auto-completion on / off globally
        local cmp_enabled = true
        vim.api.nvim_create_user_command('CmpEnableToggle', function()
            cmp_enabled = not cmp_enabled
        end, {})

        cmp.setup {
            --- The default 'enabled' function turns off cmp whenever a macro is being recorded.
            --- This is done to prevent potential buggy behaviour. However, I very often accidentally
            --- start recording a macro, unintentionally turning off cmp, which I find frustrating.
            --- I very rarely, if ever, use macros that depend on autocompletion. My implementation
            --- relaxes the original enabled conditions to prevent frustration.
            ---@see https://github.com/hrsh7th/nvim-cmp/issues/1692#issuecomment-1757918598l
            enabled = function()
                local buffer_is_not_prompt = vim.api.nvim_buf_get_option(0, 'buftype') ~= 'prompt'
                local macro_is_not_executing = vim.fn.reg_executing() == ''

                return cmp_enabled and buffer_is_not_prompt and macro_is_not_executing
            end,
            -- Setup snippet expansion
            snippet = {
                expand = function(args)
                    luasnip.lsp_expand(args.body)
                end,
            },
            -- Mappings
            mapping = cmp.mapping.preset.insert {
                ['<C-k>'] = cmp.mapping(function()
                    if cmp.visible_docs() then
                        cmp.close_docs()
                    else
                        cmp.open_docs()
                    end
                end),
                ['<C-b>'] = cmp.mapping.scroll_docs(-4),
                ['<C-f>'] = cmp.mapping.scroll_docs(4),
                ['<Tab>'] = cmp.mapping(function(fallback)
                    if cmp.visible() then
                        cmp.select_next_item()
                    elseif luasnip.expand_or_jumpable() then
                        luasnip.expand_or_jump()
                    else
                        fallback()
                    end
                end, { 'i', 's' }),
                ['<S-Tab>'] = cmp.mapping(function(fallback)
                    if cmp.visible() then
                        cmp.select_prev_item()
                    elseif luasnip.jumpable(-1) then
                        luasnip.jump(-1)
                    else
                        fallback()
                    end
                end, { 'i', 's' }),
                ['<C-n>'] = cmp.mapping(function(fallback)
                    if cmp.visible() then
                        cmp.select_next_item()
                    else
                        fallback()
                    end
                end),
                ['<C-p>'] = cmp.mapping(function(fallback)
                    if cmp.visible() then
                        cmp.select_prev_item()
                    else
                        fallback()
                    end
                end),
                ['<C-Space>'] = cmp.mapping.complete {},
                ['<C-e>'] = cmp.mapping.abort(),
                ['<CR>'] = cmp.mapping.confirm { select = true },
            },
            --- Default sources
            sources = cmp.config.sources({
                { name = 'nvim_lsp' },
                { name = 'luasnip' },
            }, {
                { name = 'buffer' },
            }),
            --- Use virtual text to "preview" completion
            experimental = {
                ghost_text = true,
            },
            --- Don't open docs by default, the occupy way too much space by default
            view = {
                docs = {
                    auto_open = false,
                },
            },
        }

        -- Set configuration for specific filetype. Just an example for now
        cmp.setup.filetype('gitcommit', {
            sources = cmp.config.sources {
                { name = 'buffer' },
            },
        })

        -- Use buffer source for `/` and `?`
        cmp.setup.cmdline({ '/', '?' }, {
            mapping = cmp.mapping.preset.cmdline(),
            sources = {
                { name = 'buffer' },
            },
        })

        -- Use cmdline & path source for ':'
        cmp.setup.cmdline(':', {
            mapping = cmp.mapping.preset.cmdline(),
            sources = cmp.config.sources({
                { name = 'path' },
            }, {
                { name = 'cmdline' },
            }),
        })
    end,
}
