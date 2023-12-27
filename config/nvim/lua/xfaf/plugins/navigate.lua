return {
    "tpope/vim-vinegar",
    {
        "stevearc/oil.nvim",
        config = true,
        keys = {
            { "-", "<cmd>Oil<CR>" }
        }
    },
    {
        "chrisgrieser/nvim-spider",
        keys = {
            { "w",  "<cmd>lua require('spider').motion('w')<CR>",  mode = { "n", "o", "x" } },
            { "e",  "<cmd>lua require('spider').motion('e')<CR>",  mode = { "n", "o", "x" } },
            { "b",  "<cmd>lua require('spider').motion('b')<CR>",  mode = { "n", "o", "x" } },
            { "ge", "<cmd>lua require('spider').motion('ge')<CR>", mode = { "n", "o", "x" } },
        }
    },
    {
        "gbprod/stay-in-place.nvim",
        config = true,
        event = "User VisualEnter"
    },
    {
        "ggandor/leap.nvim",
        keys = {
            { "s",  "<Plug>(leap-forward-to)",  mode = { "n", "x", "o" } },
            { "S",  "<Plug>(leap-backward-to)", mode = { "n", "x", "o" } },
            { "gs", "<Plug>(leap-from-window)", mode = { "n", "x", "o" } },
        },
        config = function()
            require('leap').add_repeat_mappings(';', ',', {
                relative_directions = true,
                modes = { 'n', 'x', 'o' },
            })
        end
    },
    {
        "christoomey/vim-tmux-navigator",
        keys = {
            { "<A-l>", "<cmd>TmuxNavigateRight<CR>" },
            { "<A-h>", "<cmd>TmuxNavigateLeft<CR>" },
            { "<A-j>", "<cmd>TmuxNavigateDown<CR>" },
            { "<A-k>", "<cmd>TmuxNavigateUp<CR>" },
            { "<A-,>", "<cmd>TmuxNavigatePrevious<CR>" },
        },
        init = function()
            vim.g.tmux_navigator_no_mappings = 1
            vim.g.tmux_navigator_save_on_switch = 2
        end
    },
}
