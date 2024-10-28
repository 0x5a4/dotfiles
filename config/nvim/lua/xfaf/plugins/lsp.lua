return {
    {
        "nvimtools/none-ls.nvim",
        lazy = true,
        cmd = { "NullLsLog" },
        config = function()
            local null_ls = require("null-ls")
            local diagnostics = null_ls.builtins.diagnostics
            local formatting = null_ls.builtins.formatting
            local code_actions = null_ls.builtins.code_actions

            null_ls.setup({
                sources = {
                    -- Dockerfile
                    diagnostics.hadolint,
                    -- Fish
                    diagnostics.fish,
                    -- Python
                    formatting.black,
                    -- All of that Web dev shit (also markdown)
                    null_ls.builtins.formatting.prettierd.with({
                        -- you fuck up hugo like no one else can
                        disabled_filetypes = { "html", "css" },
                    }),
                },
                border = "rounded",
            })
        end,
    },
    {
        "neovim/nvim-lspconfig",
        dependencies = {
            "nvimtools/none-ls.nvim",
            "ray-x/lsp_signature.nvim",
        },
        cmd = { "LspLog", "LspStart" },
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

            -- Javascript/Typescript
            lspconfig.ts_ls.setup({})

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
                        format = {
                            defaultConfig = {
                                quote_style = "double",
                                trailing_table_separator = "smart",
                                end_statement_with_semicolon = "replace_with_newline",
                                line_space_after_do_statement = "fixed(2)",
                                line_space_after_for_statement = "fixed(2)",
                                line_space_after_if_statement = "fixed(2)",
                                line_space_after_repeat_statement = "fixed(2)",
                                line_space_after_while_statement = "fixed(2)",
                            },
                        },
                    },
                },
            })

            -- Rust
            lspconfig.rust_analyzer.setup({})

            -- Nix
            lspconfig.nixd.setup({
                cmd = { "nixd" },
                settings = {
                    nixd = {
                        nixpkgs = {
                            expr = "import <nixpkgs> { }",
                        },
                        formatting = {
                            command = { "alejandra" },
                        },
                        options = {
                            nixos = {
                                expr = '(builtins.getFlake "self").nixosConfigurations.fword.options',
                            },
                        },
                    },
                },
            })

            -- Python
            lspconfig.pyright.setup({})

            -- Zig
            lspconfig.zls.setup({})
        end,
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
    },
    {
        "stevearc/conform.nvim",
        event = { "BufWritePre" },
        cmd = { "ConformInfo" },
        keys = {
            {
                "<C-f>",
                function()
                    require("conform").format({ async = true, lsp_fallback = true })
                end,
                mode = "",
            },
        },
        opts = {},
        init = function()
            vim.o.formatexpr = "v:lua.require'conform'.formatexpr()"
        end,
    },
}
