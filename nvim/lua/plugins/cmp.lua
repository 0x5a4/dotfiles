return {
    {
        "hrsh7th/nvim-cmp", 
        config = function() 
            local cmp = require("cmp")
            local cmp_autopairs = require("nvim-autopairs.completion.cmp")

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
                    { name = "crates" },
                }),
            }

            cmp.event:on(
                'confirm_done',
                cmp_autopairs.on_confirm_done {
                    filetypes = {
                        tex = false,
                        plaintex = false,
                    }
                }
            )
        end 
    },
    
    -- cmp sources
    "hrsh7th/cmp-nvim-lsp",
    "hrsh7th/cmp-path",
    {
        "hrsh7th/cmp-vsnip",
        dependencies = "hrsh7th/vim-vsnip"
    },
    "rafamadriz/friendly-snippets",
    {
        "saecki/crates.nvim",
        tag = 'v0.3.0',
        dependencies =  "nvim-lua/plenary.nvim",
        config = true,
        event = "BufEnter Cargo.toml",
    }
}
