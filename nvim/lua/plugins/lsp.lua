local h = require("helper")

h.nnoremap("gd", "<cmd>lua vim.lsp.buf.definition()<CR>")
h.nnoremap("gi", "<cmd>lua vim.lsp.buf.implementation()<CR>")
h.nnoremap("gu", "<cmd>lua vim.lsp.buf.incoming_calls()<CR>")
h.nnoremap("<C-Space>", "<cmd>lua vim.lsp.buf.code_action()<CR>")
h.nnoremap("<leader>rn", "<cmd>lua vim.lsp.buf.rename()<CR>")
h.nnoremap("<C-F>", "<cmd>lua vim.lsp.buf.formatting()<CR>")

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

--Completion popup
vim.diagnostic.config({
    virtual_text = true,
    signs = false,
    float = { border = "single" },
    update_in_insert = true,
})

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
        ['<C-J>'] = cmp.mapping(cmp.mapping.scroll_docs(4)),
        ['<C-K>'] = cmp.mapping(cmp.mapping.scroll_docs(-4)),
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
