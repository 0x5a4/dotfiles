return {
    {
        "nvim-treesitter/nvim-treesitter",
        event = "User File",
        cmd = {
            "TSUpdate",
            "TSUpdateSync",
        },
        build = function()
            require("nvim-treesitter.install").update()
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
                true,
            },
        },
        main = "nvim-treesitter.configs",
    },

    -- random filetypes
    {
        "fladson/vim-kitty",
        ft = "kitty",
    },
    {
        "ziglang/zig.vim",
        ft = "zig",
        init = function()
            vim.g.zig_fmt_parse_errors = 0
        end,
    },
    "phelipetls/vim-hugo",
    "sevko/vim-nand2tetris-syntax",
}
