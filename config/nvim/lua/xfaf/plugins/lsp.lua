return {
    {
        "nvimtools/none-ls.nvim",
        lazy = true,
        cmd = { "NullLsLog" },
        config = function()
            local null_ls = require("null-ls");
            local diagnostics = null_ls.builtins.diagnostics
            local formatting = null_ls.builtins.formatting
            local code_actions = null_ls.builtins.code_actions

            null_ls.setup({
                sources = {
                    -- Dockerfile
                    diagnostics.hadolint,
                    -- Fish
                    diagnostics.fish,
                    -- Nix
                    code_actions.statix,
                    formatting.alejandra,
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
        end
    },
    {
        "williamboman/mason.nvim",
        cmd = { "Mason", "MasonUpdate" },
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

            -- Nix
            lspconfig.nil_ls.setup({})

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
        -- Everything in opts will be passed to setup()
        opts = {
            -- Define your formatters
            formatters_by_ft = {
                lua = { "stylua" },
                python = { "isort", "black" },
                javascript = { { "prettierd", "prettier" } },
            },
        },
        init = function()
            vim.o.formatexpr = "v:lua.require'conform'.formatexpr()"
        end,
    }
}
