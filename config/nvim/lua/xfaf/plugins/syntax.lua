return {
    {
        "nvim-treesitter/nvim-treesitter",
        event = "User File",
        dependencies = {
            "p00f/nvim-ts-rainbow",
        },
        build = function()
            require("nvim-treesitter.install").update({ with_sync = true })
        end,
        opts = {
            ensure_installed = {
                "bash",
                "c",
                "clojure",
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
                "html",
                "ini",
                "java",
                "javascript",
                "json",
                "kotlin",
                "latex",
                "lua",
                "make",
                "markdown",
                "markdown_inline",
                "meson",
                "ninja",
                "nix",
                "python",
                "regex",
                "rust",
                "scss",
                "sql",
                "toml",
                "typescript",
                "vim",
                "yaml",
                "zig",
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
        },
        main = "nvim-treesitter.configs",
    },

    -- random filetypes
    "gentoo/gentoo-syntax",
    {
        "fladson/vim-kitty",
        ft = "kitty"
    },
    {
        "theRealCarneiro/hyprland-vim-syntax",
        ft = "hypr"
    },
    {
        "zig-lang/zig.vim",
        ft = "zig"
    },
}
