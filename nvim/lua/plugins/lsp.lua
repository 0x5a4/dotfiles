local cap = require('cmp_nvim_lsp').update_capabilities(vim.lsp.protocol.make_client_capabilities())

local lsp = require("nvim-lsp-installer")

lsp.on_server_ready(function(server)
    if server.name == "rust_analyzer" then
        require("rust-tools").setup({
            server = {
                cmd = server:get_default_options().cmd,
                sta = false,
                settings = {
                    ["rust-analyzer"] = {
                        checkOnSave = {
                            command = "clippy"
                        },
                    }
                }
            }
        })
    elseif server.name == "sumneko_lua" then
        server:setup(require("lua-dev").setup({
            capabilities = cap
        }))
    else
        server:setup({
            capabilities = cap,
        })
    end

    vim.cmd[[do User LspAttachBuffers]]
end)

-- Completion
local cmp = require('cmp')

cmp.setup({
    snippet = {
        expand = function(args)
            vim.fn["vsnip#anonymous"](args.body)
        end,
    },
    mapping = {
        ['<C-j>'] = cmp.mapping(cmp.mapping.select_next_item()),
        ['<C-k>'] = cmp.mapping(cmp.mapping.select_prev_item()),
        ['<C-w>'] = cmp.mapping(cmp.mapping.scroll_docs(4)),
        ['<C-s>'] = cmp.mapping(cmp.mapping.scroll_docs(-4)),
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
    }),
})
