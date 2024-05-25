return {
    {
        "nvim-treesitter/nvim-treesitter",
        event = "User File",
        cmd = {
            "TSUpdate",
            "TSUpdateSync"
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
                "hyprlang",
                "ini",
                "java",
                "javascript",
                "json",
                "just",
                "kotlin",
                "lua",
                "make",
                "markdown",
                "markdown_inline",
                "meson",
                "nasm",
                "ninja",
                "nix",
                "perl",
                "python",
                "regex",
                "rust",
                "scss",
                "sql",
                "ssh_config",
                "tmux",
                "toml",
                "typescript",
                "vim",
                "vimdoc",
                "xml",
                "yaml",
                "zig",
            },
            highlight = {
                enable = true,
            },
            indent = {
                true
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
        "ziglang/zig.vim",
        ft = "zig"
    },
    "phelipetls/vim-hugo",
    "sevko/vim-nand2tetris-syntax"
}
