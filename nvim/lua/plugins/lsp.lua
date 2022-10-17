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
    local current_path = vim.fn.getcwd()
    local is_nvim_dev = current_path:find("dotfiles")
    if is_nvim_dev then
        local luadev = require("lua-dev").setup {}
        lspconfig.sumneko_lua.setup(luadev)
    else
        lspconfig.sumneko_lua.setup({})
    end

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
