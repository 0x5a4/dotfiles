return function()
    local ts = require("nvim-treesitter.configs")

    -- Folding
    vim.g.foldmethod = "expr"
    vim.g.foldexpr = "nvim_treesitter#foldexpr()"

    ts.setup {
        ensure_installed = { "rust", "lua", "bash", "fish", "python", "toml", "yaml", "vim", "json", "java" },
        rainbow = {
            enable = true,
        },
        textobjects = {
            select = {
                enable = true,
                lookahead = true,
                keymaps = {
                    ["af"] = "@function.outer",
                    ["if"] = "@function.inner",
                    ["ac"] = "@class.outer",
                    ["ic"] = "@class.inner",
                    ["ab"] = "@block.outer",
                    ["ib"] = "@block.inner",
                }
            }
        }
    }
end
