return {
    {
        "nvimtools/none-ls.nvim",
        event = "VeryLazy",
        config = function()
            local null_ls = require("null-ls");
            local diagnostics = null_ls.builtins.diagnostics
            local formatting = null_ls.builtins.formatting
            local code_actions = null_ls.builtins.code_actions

            null_ls.setup({
                sources = {
                    -- Bash
                    formatting.beautysh,
                    -- C/C++
                    formatting.clang_format,
                    -- Dockerfile
                    diagnostics.hadolint,
                    -- Fish
                    diagnostics.fish,
                    -- JSON
                    formatting.fixjson,
                    -- Markdown
                    formatting.cbfmt,
                    -- Nix
                    code_actions.statix,
                    formatting.alejandra,
                    -- Python
                    diagnostics.ruff,
                    formatting.black,
                    -- TOML
                    formatting.taplo,
                },
                border = "rounded",
                on_attach = function(client, bufnr)
                    local augroup = vim.api.nvim_create_augroup("LspFormatting", {})

                    if client.supports_method("textDocument/formatting") then
                        vim.api.nvim_clear_autocmds({
                            group = augroup,
                            buffer = bufnr,
                        })
                        vim.api.nvim_create_autocmd("BufWritePre", {
                            group = augroup,
                            buffer = bufnr,
                            callback = function()
                                vim.lsp.buf.format({ bufnr = bufnr })
                            end,
                        })
                    end
                end,
            })
        end
    },
    {
        "williamboman/mason.nvim",
        build = ":MasonUpdate", -- :MasonUpdate updates registry contents
        opts = {
            ui = {
                border = "rounded"
            }
        },
    },
    {
        "WhoIsSethDaniel/mason-tool-installer.nvim",
        opts = {
            ensure_installed = {
                -- Bash
                "bash-language-server",
                "beautysh",
                -- C/C++
                "clangd",
                "clang-format",
                -- Dockerfile
                "hadolint",
                -- Haskell
                "hls",
                -- Java
                "jdtls",
                -- Javascript/Typescript
                "typescript-language-server",
                -- JSON
                "fixjson",
                -- LaTeX
                "texlab",
                -- Lua
                "lua-language-server",
                -- Markdown
                "cbfmt",
                "marksman",
                -- Python
                "black",
                "pyright",
                "ruff",
                -- Rust
                "rust-analyzer",
                -- TOML
                "taplo",
                -- Zig
                "zls",
            }
        },
        event = "VeryLazy"
    },
    {
        "williamboman/mason-lspconfig.nvim",
        event = "User File",
        dependencies = {
            "neovim/nvim-lspconfig",
            "williamboman/mason.nvim"
        },
        config = true
    },
    {
        "neovim/nvim-lspconfig",
        event = "User File",
        config = function()
            vim.cmd [[autocmd! ColorScheme * highlight NormalFloat guibg=#1f2335]]
            vim.cmd [[autocmd! ColorScheme * highlight FloatBorder guifg=white guibg=#1f2335]]

            local border = {
                { "╭", "FloatBorder" },
                { "─", "FloatBorder" },
                { "╮", "FloatBorder" },
                { "│", "FloatBorder" },
                { "╯", "FloatBorder" },
                { "─", "FloatBorder" },
                { "╰", "FloatBorder" },
                { "│", "FloatBorder" },
            }

            local orig_util_open_floating_preview = vim.lsp.util.open_floating_preview
            function vim.lsp.util.open_floating_preview(contents, syntax, opts, ...)
                opts = opts or {}
                opts.border = opts.border or border
                return orig_util_open_floating_preview(contents, syntax, opts, ...)
            end

            local lspconfig = require("lspconfig")

            -- Bash
            lspconfig.bashls.setup({})

            -- C/C++
            lspconfig.clangd.setup({})

            -- Haskell
            lspconfig.hls.setup({})

            -- Java
            lspconfig.jdtls.setup({})

            -- Javascript/Typescript
            lspconfig.tsserver.setup({})

            -- LaTeX
            lspconfig.texlab.setup({})

            -- Lua
            lspconfig.lua_ls.setup({})

            -- Markdown
            lspconfig.marksman.setup({})

            -- Python
            lspconfig.pyright.setup({})

            -- Rust
            lspconfig.rust_analyzer.setup({})

            -- Zig
            lspconfig.zls.setup({})
        end
    },
}
