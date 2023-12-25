return {
    "wellle/targets.vim",
    "tpope/vim-surround",
    "svermeulen/vim-cutlass",
    {
        "tpope/vim-commentary",
        keys = { { "gc", nil, mode = { "n", "x", "o" } } }
    },
    {
        "julienvincent/nvim-paredit",
        ft = { "clojure" },
        config = true,
    },
    {
        "mizlan/iswap.nvim",
        cmd = {
            "ISwap",
            "ISwapWith",
            "ISwapWithLeft",
            "ISwapWithRight",
            "ISwapNode",
            "ISwapNodeWith",
            "ISwapNodeWithLeft",
            "ISwapNodeWithRight",
            "IMove",
            "IMoveWith",
            "IMoveWithLeft",
            "IMoveWithRight",
            "IMoveNode",
            "IMoveNodeWith",
            "IMoveNodeWithLeft",
            "IMoveNodeWithRight",
        },
        keys = {
            { "<leader>a", "<cmd>ISwapWith<CR>" },
            { "<leader>A", "<cmd>ISwap<CR>" },
        }
    },
    {
        "windwp/nvim-autopairs",
        event = "InsertEnter",
        config = function()
            local autopairs = require("nvim-autopairs")
            local cond = require("nvim-autopairs.conds")
            local rule = require("nvim-autopairs.rule")

            autopairs.setup({})

            -- dont automatically duble quote in lisps
            autopairs.get_rules("'")[1].not_filetypes = { "scheme", "lisp", "clojure" }


            autopairs.add_rules({
                rule("$", "$", { "tex", "latex" })
            })
        end
    },
    {
        "matze/vim-move",
        keys = {
            { "<C-h>", nil, mode = { "n", "x" } },
            { "<C-j>", nil, mode = { "n", "x" } },
            { "<C-k>", nil, mode = { "n", "x" } },
            { "<C-l>", nil, mode = { "n", "x" } },
        },
        init = function()
            vim.g.move_key_modifier = "C"
            vim.g.move_key_modifier_visualmode = "C"
        end
    },
    {
        "rmagatti/alternate-toggler",
        keys = {
            { "<leader>+", "<cmd>ToggleAlternate<CR>" }
        },
        cmd = "ToggleAlternate"
    },
}
