return {
    "tpope/vim-vinegar",
    {
        "stevearc/oil.nvim",
        lazy = false,
        cmd = "Oil",
        keys = {
            { "-", "<cmd>Oil<CR>" }
        },
        opts = {
            columns = {
                "icon",
                "size",
            },
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
        "folke/flash.nvim",
        event = "VeryLazy",
        opts = {},
        keys = {
            { "s",     mode = { "n", "x", "o" }, function() require("flash").jump() end, },
            { "S",     mode = { "n", "x", "o" }, function() require("flash").treesitter() end, },
            { "r",     mode = "o",               function() require("flash").remote() end, },
            { "R",     mode = { "o", "x" },      function() require("flash").treesitter_search() end, },
            { "<c-s>", mode = { "c" },           function() require("flash").toggle() end, },
            {
                "gs",
                mode = { "n", "x", "o" },
                function()
                    require("flash").jump({
                        search = { mode = "search", max_length = 0 },
                        label = { after = { 0, 0 } },
                        pattern = "^"
                    })
                end
            },
        },
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
