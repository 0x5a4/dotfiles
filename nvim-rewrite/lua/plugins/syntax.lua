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
                    "rust",
                    "lua",
                    "bash",
                    "fish",
                    "python",
                    "toml",
                    "yaml",
                    "vim",
                    "json",
                    "java",
                    "c",
                    "cmake",
                    "cpp",
                    "diff",
                    "dockerfile",
                    "gitattributes",
                    "lalrpop",
                    "kotlin",
                    "latex",
                    "make",
                    "markdown",
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
    "fladson/vim-kitty",
    "elkowar/yuck.vim",
    "gentoo/gentoo-syntax",
    "theRealCarneiro/hyprland-vim-syntax",
    "zig-lang/zig.vim"
}
