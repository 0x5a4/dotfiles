return function()
    require("nvim-lsp-installer").setup {}
    local lspconfig = require("lspconfig");

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
    lspconfig.sumneko_lua.setup {}

    -- bashls
    lspconfig.bashls.setup {}

    -- Marksman(Markdown)
    lspconfig.marksman.setup {}

    -- JDT
    lspconfig.jdtls.setup {}

    -- clangd
    lspconfig.clangd.setup {}

    -- ltex
    -- lspconfig.ltex.setup {
    --     settings = {
    --         ltex = {
    --             language = "en-US"
    --         }
    --     }
    -- }
end
