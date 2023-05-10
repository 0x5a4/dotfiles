return {
    "tpope/vim-repeat",
    "tpope/vim-vinegar",
    "tpope/vim-surround",
    "tpope/vim-commentary",
    {
        "moll/vim-bbye",
        cmd = "Bdelete"
    },
    "wellle/targets.vim",
    "jbyuki/venn.nvim",
    "svermeulen/vim-cutlass",
    "jghauser/mkdir.nvim",

    {
        "rmagatti/alternate-toggler",
        cmd = "ToggleAlternate"
    },

    {
        "max397574/better-escape.nvim",
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
    -- auf und zu
    {
        "windwp/nvim-autopairs",
        config = true
    },
    {
        "xuhdev/vim-latex-live-preview",
        init = function()
            vim.g.livepreview_previewer = 'zathura'
            vim.g.livepreview_cursorhold_recompile = 3
        end,
        cmd = "LLPStartPreview"
    },
    {
        "iamcco/markdown-preview.nvim",
        build = function() vim.fn["mkdp#util#install"]() end,
        ft = "markdown"
    },
    {
        "christoomey/vim-tmux-navigator",
        init = function()
            vim.g.tmux_navigator_no_mappings = 1
            vim.g.tmux_navigator_save_on_switch = 2
        end
    },
    --todo
    {
        "folke/todo-comments.nvim",
        dependencies = "nvim-lua/plenary.nvim",
        config = true
    },
    {
        "ggandor/leap.nvim",
        config = function()
            require("leap").set_default_keymaps()
        end
    },
    {
        "gbprod/stay-in-place.nvim",
        config = true
    },
    {
        "axieax/urlview.nvim",
        config = true
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
        opts = {
            signcolumn = false,
            numhl = true,
            linehl = false,
        }
    }
}
