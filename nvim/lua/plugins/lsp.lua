return function()
    require("nvim-lsp-installer").setup {}
    local lspconfig = require("lspconfig");

    -- rust tools
    require("rust-tools").setup{
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
    local luadev = require("lua-dev").setup{}
    lspconfig.sumneko_lua.setup(luadev)

    -- bashls
    lspconfig.bashls.setup{}

    -- Marksman(Markdown)
    lspconfig.marksman.setup{}

    -- JDT
    lspconfig.jdtls.setup{}
end
