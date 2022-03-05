local ts = require("nvim-treesitter.configs")
local h = require("helper")

-- Folding
h.glet({
    ["foldmethod"] = "expr",
    ["foldexpr"] = "nvim_treesitter#foldexpr()",
})

ts.setup {
    ensure_installed = {"rust", "lua", "bash", "fish", "python", "toml", "yaml", "vim", "json" },
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
