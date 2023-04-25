-- Category: completion

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

        cmp.setup {
            -- Setup snippet expansion
            snippet = {
                expand = function(args)
                    luasnip.lsp_expand(args.body)
                end,
            },
            -- Mappings
            mapping = cmp.mapping.preset.insert {
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
                ['<C-Space>'] = cmp.mapping.complete {},
                ['<C-e>'] = cmp.mapping.abort(),
                ['<CR>'] = cmp.mapping.confirm { select = true },
            },
            -- Default sources
            sources = cmp.config.sources({
                { name = 'nvim_lsp' },
                { name = 'luasnip' },
            }, {
                { name = 'buffer' },
            }),
            experimental = {
                -- Use virtual text to "preview" completion
                ghost_text = true,
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
