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
        cmd = { "VBox", "VBoxO", "VBoxD", "VBoxDO", "VBoxH", "VBoxHO" },
        keys = { {
            "<leader>ov",
            function()
                local venn_enabled = vim.inspect(vim.b.venn_enabled)
                if venn_enabled == "nil" then
                    vim.b.venn_enabled = true
                    vim.cmd [[setlocal ve=all]]
                    -- draw a line on HJKL keystokes
                    vim.api.nvim_buf_set_keymap(0, "n", "J", "<C-v>j:VBox<CR>", { noremap = true })
                    vim.api.nvim_buf_set_keymap(0, "n", "K", "<C-v>k:VBox<CR>", { noremap = true })
                    vim.api.nvim_buf_set_keymap(0, "n", "L", "<C-v>l:VBox<CR>", { noremap = true })
                    vim.api.nvim_buf_set_keymap(0, "n", "H", "<C-v>h:VBox<CR>", { noremap = true })
                    -- draw a box by pressing "f" with visual selection
                    vim.api.nvim_buf_set_keymap(0, "v", "f", ":VBox<CR>", { noremap = true })
                else
                    vim.cmd [[setlocal ve=]]
                    vim.cmd [[mapclear <buffer>]]
                    vim.b.venn_enabled = nil
                end
            end,
            noremap = true,
            silent = true,
        } }
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
        keys = {
            { "<C-h>", nil, mode = { "n", "x", "o" } },
            { "<C-j>", nil, mode = { "n", "x", "o" } },
            { "<C-k>", nil, mode = { "n", "x", "o" } },
            { "<C-l>", nil, mode = { "n", "x", "o" } },
        },
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
        keys = {
            { "<A-t>", '<cmd>lua require("FTerm").toggle()<CR>' },
            { "<A-t>", '<C-\\><C-n><CMD>lua require("FTerm").toggle()<CR>', mode = { "t" } }
        },
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
        keys = {
            { "w",  "<cmd>lua require('spider').motion('w')<CR>",  mode = { "n", "o", "x" } },
            { "e",  "<cmd>lua require('spider').motion('e')<CR>",  mode = { "n", "o", "x" } },
            { "b",  "<cmd>lua require('spider').motion('b')<CR>",  mode = { "n", "o", "x" } },
            { "ge", "<cmd>lua require('spider').motion('ge')<CR>", mode = { "n", "o", "x" } },
        }
    },
    {
        "gorbit99/codewindow.nvim",
        config = true,
        keys = {
            { "<leader>vc", "<cmd>lua require('codewindow').toggle_minimap()<CR>" },
        }
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
    "ckarnell/Antonys-macro-repeater"
}
