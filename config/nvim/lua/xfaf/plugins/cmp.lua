return {
    {
        "hrsh7th/nvim-cmp",
        event = "InsertEnter",
        dependencies = {
            { "hrsh7th/cmp-nvim-lsp",     lazy = true, },
            { "hrsh7th/cmp-path",         lazy = true, },
            { "hrsh7th/cmp-nvim-lua",     lazy = true, },
            { "saadparwaiz1/cmp_luasnip", lazy = true, },
            {
                "petertriho/cmp-git",
                lazy = true,
                opts = {}
            },
        },
        config = function()
            local cmp = require("cmp")
            local cmp_autopairs = require("nvim-autopairs.completion.cmp")

            cmp.setup {
                snippet = {
                    expand = function(args)
                        require("luasnip").lsp_expand(args.body)
                    end,
                },
                -- Shamelessly stolen from the nvchad config
                window = {
                    completion = {
                        border = {
                            { "╭", "CmpBorder" },
                            { "─", "CmpBorder" },
                            { "╮", "CmpBorder" },
                            { "│", "CmpBorder" },
                            { "╯", "CmpBorder" },
                            { "─", "CmpBorder" },
                            { "╰", "CmpBorder" },
                            { "│", "CmpBorder" },
                        }
                    },
                    documentation = {
                        border = {
                            { "╭", "CmpDocBorder" },
                            { "─", "CmpDocBorder" },
                            { "╮", "CmpDocBorder" },
                            { "│", "CmpDocBorder" },
                            { "╯", "CmpDocBorder" },
                            { "─", "CmpDocBorder" },
                            { "╰", "CmpDocBorder" },
                            { "│", "CmpDocBorder" },
                        },
                        winhighlight = "Normal:CmpDoc",
                    },
                },
                mapping = {
                    ["<C-j>"] = cmp.mapping(cmp.mapping.select_next_item()),
                    ["<C-k>"] = cmp.mapping(cmp.mapping.select_prev_item()),
                    ["<C-s>"] = cmp.mapping(cmp.mapping.scroll_docs(4)),
                    ["<C-w>"] = cmp.mapping(cmp.mapping.scroll_docs(-4)),
                    ["<C-Space>"] = function()
                        if cmp.visible() then
                            cmp.confirm()
                        else
                            cmp.complete()
                        end
                    end,
                    ["<CR>"] = cmp.mapping.confirm {},
                    ["<Esc>"] = cmp.mapping.abort {},
                },
                sources = cmp.config.sources({
                    { name = "luasnip", priority = 100 },
                    { name = "nvim_lsp" },
                    { name = "path" },
                    { name = "crates" },
                    { name = "nvim_lua" },
                    { name = "git" },
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
    {
        "saecki/crates.nvim",
        tag = 'v0.3.0',
        dependencies = "nvim-lua/plenary.nvim",
        config = true,
        event = "BufEnter Cargo.toml",
    }
}
