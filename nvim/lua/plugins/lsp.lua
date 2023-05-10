return {
    "simrat39/rust-tools.nvim",
    "folke/neodev.nvim",
    {
        "williamboman/mason.nvim",
        build = ":MasonUpdate", -- :MasonUpdate updates registry contents
        config = true,
    },
    {
        "williamboman/mason-lspconfig.nvim",
        dependencies = {
            "neovim/nvim-lspconfig",
            "williamboman/mason.nvim"
        },
        config = function()
            require("mason-lspconfig").setup {
                automatic_installation = true,
            }

            local lspconfig = require("lspconfig")

            -- rust tools
            require("rust-tools").setup {
                server = {
                    standalone = false,
                    settings = {
                        ["rust-analyzer"] = {
                            checkOnSave = {
                                command = "clippy"
                            },
                        }
                    }
                }
            }

            -- lua dev
            require("neodev").setup {}
            lspconfig.lua_ls.setup {}

            -- bashls
            lspconfig.bashls.setup {}

            -- Marksman(Markdown)
            lspconfig.marksman.setup {}

            -- JDT
            lspconfig.jdtls.setup {}

            -- clangd
            lspconfig.clangd.setup {}

            -- ltex
            lspconfig.texlab.setup {}

            -- zls
            lspconfig.zls.setup {}
        end,
    }
}
