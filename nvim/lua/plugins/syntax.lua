return {
    {
        "nvim-treesitter/nvim-treesitter",
        build = function()
            require("nvim-treesitter.install").update({ with_sync = true })
        end,
        config = function()
            local ts = require("nvim-treesitter.configs")

            ts.setup {
                -- Hopefully anything i might come across in the near future
                ensure_installed = {
                    "bash",
                    "c",
                    "cmake",
                    "cpp",
                    "css",
                    "diff",
                    "dockerfile",
                    "fish",
                    "gitattributes",
                    "gitcommit",
                    "git_config",
                    "gitignore",
                    "git_rebase",
                    "html",
                    "ini",
                    "java",
                    "json",
                    "kotlin",
                    "latex",
                    "lua",
                    "make",
                    "markdown",
                    "meson",
                    "python",
                    "rust",
                    "toml",
                    "vim",
                    "yaml",
                    "zig"
                },
                highlight = {
                    enable = true,
                },
                indent = {
                    true
                },
                rainbow = {
                    enable = true,
                },
            }
        end
    },

    "p00f/nvim-ts-rainbow",
    {
        "fladson/vim-kitty",
        ft = "kitty"
    },
    "gentoo/gentoo-syntax",
    "theRealCarneiro/hyprland-vim-syntax",
    {
        "zig-lang/zig.vim",
        ft = "zig"
    }
}
