return {
    "tpope/vim-repeat",
    "tpope/vim-vinegar",
    "tpope/vim-surround",
    "tpope/vim-commentary",
    {
        "famiu/bufdelete.nvim",
        keys = {
            { "<leader>c", "<cmd>Bdelete<CR>" }
        },
        cmd = { "Bdelete", "Bwipeout" },
    },
    "wellle/targets.vim",
    {
        "jbyuki/venn.nvim",
        cmd = { "VBox", "VBoxO", "VBoxD", "VBoxDO", "VBoxH", "VBoxHO" }
    },
    "svermeulen/vim-cutlass",
    "jghauser/mkdir.nvim",
    {
        "rmagatti/alternate-toggler",
        keys = {
            { "<leader>+", "<cmd>ToggleAlternate<CR>" }
        },
        cmd = "ToggleAlternate"
    },
    {
        "max397574/better-escape.nvim",
        event = "InsertEnter",
        opts = {
            mapping = { "kj" },
            timeout = 500,
            clear_empty_lines = true,
        }
    },
    {
        "matze/vim-move",
        init = function()
            vim.g.move_key_modifier = "C"
            vim.g.move_key_modifier_visualmode = "C"
        end
    },
    {
        "windwp/nvim-autopairs",
        event = "InsertEnter",
        config = true,
    },
    {
        "xuhdev/vim-latex-live-preview",
        init = function()
            vim.g.livepreview_previewer = 'zathura'
            vim.g.livepreview_cursorhold_recompile = 3
        end,
        keys = {
            { "<leader>vt", "<cmd>LLPStartPreview<CR>" },
        },
        cmd = "LLPStartPreview"
    },
    {
        "iamcco/markdown-preview.nvim",
        build = function() vim.fn["mkdp#util#install"]() end,
        keys = {
            { "<leader>vm", "<Plug>MarkdownPreviewToggle" }
        }
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
    {
        "folke/todo-comments.nvim",
        event = "User File",
        keys = {
            { "<leader>t", "<cmd>TodoTelescope<CR>" },
        },
        dependencies = "nvim-lua/plenary.nvim",
        config = true
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
        "gbprod/stay-in-place.nvim",
        config = true,
    },
    {
        "axieax/urlview.nvim",
        config = true,
        keys = {
            { "<leader>vu", "<cmd>UrlView<CR>" }
        },
        cmd = "UrlView"
    },
    {
        "numToStr/FTerm.nvim",
        lazy = true,
        opts = {
            border = 'rounded'
        }
    },
    {
        "lewis6991/gitsigns.nvim",
        dependencies = "nvim-lua/plenary.nvim",
        event = "User GitFile",
        keys = {
            { "<leader>og", "<cmd>Gitsigns toggle_linehl<CR>" }
        },
        opts = {
            signcolumn = false,
            numhl = true,
            linehl = false,
        }
    },
    {
        "RaafatTurki/hex.nvim",
        keys = {
            { "<leader>oh", "<cmd>HexToggle<CR>" },
        },
        cmd = { "HexDump", "HexAssemble", "HexToggle" },
        config = true,
    },
    {
        "chrisgrieser/nvim-spider",
        opts = {
            skipInsignificantPunctuation = true,
        },
        keys = {
            { "w",  "<cmd>lua require('spider').motion('w')<CR>",  mode = { "n", "o", "x" } },
            { "e",  "<cmd>lua require('spider').motion('e')<CR>",  mode = { "n", "o", "x" } },
            { "b",  "<cmd>lua require('spider').motion('b')<CR>",  mode = { "n", "o", "x" } },
            { "ge", "<cmd>lua require('spider').motion('ge')<CR>", mode = { "n", "o", "x" } },
        }
    }

}
