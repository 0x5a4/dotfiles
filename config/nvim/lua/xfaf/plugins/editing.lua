return {
    "wellle/targets.vim",
    "tpope/vim-surround",
    "svermeulen/vim-cutlass",
    {
        "tpope/vim-commentary",
        keys = { { "gc", nil, mode = { "n", "x", "o"} } }
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
        config = true,
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
