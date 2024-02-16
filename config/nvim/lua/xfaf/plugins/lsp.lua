return {
    {
        "nvimtools/none-ls.nvim",
        lazy = true,
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
                    -- Nix
                    code_actions.statix,
                    formatting.alejandra,
                    -- Python
                    diagnostics.ruff,
                    formatting.black,
                    -- TOML
                    formatting.taplo,
                    -- All of that Web dev shit (also markdown)
                    formatting.prettierd
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
        cmd = {
            "MasonToolsInstall",
            "MasonToolsInstallSync",
            "MasonToolsUpdate",
            "MasonToolsUpdateSync",
            "MasonToolsClean",
        },
        opts = {
            ensure_installed = {
                -- Bash
                "bash-language-server",
                "beautysh",
                -- C/C++
                "clangd",
                "clang-format",
                -- Clojure
                "clojure-lsp",
                -- HTML
                "html-lsp",
                -- Dockerfile
                "hadolint",
                -- Java
                "jdtls",
                -- Javascript/Typescript
                "typescript-language-server",
                -- LaTeX
                "texlab",
                -- Lua
                "lua-language-server",
                -- Markdown
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
                -- All of that webdev shit
                "prettierd"
            }
        },
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
        dependencies = {
            "nvimtools/none-ls.nvim",
            "ray-x/lsp_signature.nvim",
        },
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

            -- Clojure
            lspconfig.clojure_lsp.setup({})

            -- Haskell
            lspconfig.hls.setup({})

            -- HTML
            lspconfig.html.setup({
                format = {
                    enable = false,
                },
            })

            -- Java
            lspconfig.jdtls.setup({})

            -- Javascript/Typescript
            lspconfig.tsserver.setup({})

            -- LaTeX
            lspconfig.texlab.setup({})

            -- Lua
            lspconfig.lua_ls.setup({
                settings = {
                    Lua = {
                        diagnostics = {
                            globals = {
                                "vim",
                                "s",
                                "t",
                                "i",
                                "fmt",
                            },
                        },
                    },
                },
            })

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
    {
        "https://git.sr.ht/~whynothugo/lsp_lines.nvim",
        keys = {
            {
                "<leader>ol",
                function()
                    require("lsp_lines").toggle()
                end,
            },
        },
        config = function()
            require("lsp_lines").setup({})
            vim.diagnostic.config({ virtual_lines = { only_current_line = true } })
        end,
    },
    {
        "ray-x/lsp_signature.nvim",
        lazy = true,
        opts = {
            hint_prefix = "",
        },
    }
}
