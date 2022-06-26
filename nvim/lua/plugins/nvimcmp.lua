return function()
    local cmp = require('cmp')

    cmp.setup {
        snippet = {
            expand = function(args)
                vim.fn["vsnip#anonymous"](args.body)
            end,
        },
        mapping = {
            ['<C-j>'] = cmp.mapping(cmp.mapping.select_next_item()),
            ['<C-k>'] = cmp.mapping(cmp.mapping.select_prev_item()),
            ['<C-s>'] = cmp.mapping(cmp.mapping.scroll_docs(4)),
            ['<C-w>'] = cmp.mapping(cmp.mapping.scroll_docs(-4)),
            ['<C-Space>'] = function()
                if cmp.visible() then
                    cmp.confirm()
                else
                    cmp.complete()
                end
            end,
            ['<CR>'] = cmp.mapping.confirm({ select = true }),
        },
        sources = cmp.config.sources({
            { name = 'nvim_lsp' },
            { name = 'vsnip' },
            { name = 'path' },
        }),
    }
end
