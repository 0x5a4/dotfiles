return function()
    local ts = require("nvim-treesitter.configs")

    -- Folding
    vim.g.foldmethod = "expr"
    vim.g.foldexpr = "nvim_treesitter#foldexpr()"

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
