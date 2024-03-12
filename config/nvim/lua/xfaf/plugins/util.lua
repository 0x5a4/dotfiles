return {
    "ckarnell/Antonys-macro-repeater",
    "tpope/vim-repeat",
    {
        "jghauser/mkdir.nvim",
        event = "BufWritePre",
    },
    {
        "famiu/bufdelete.nvim",
        keys = {
            { "<leader>c", "<cmd>Bdelete<CR>" }
        },
        cmd = { "Bdelete", "Bwipeout" },
    },
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
        "xuhdev/vim-latex-live-preview",
        init = function()
            vim.g.livepreview_previewer = 'zathura'
            vim.g.livepreview_cursorhold_recompile = 3
        end,
        keys = {
            { "<leader>vt", "<cmd>LLPStartPreview<CR>" },
        },
        cmd = { "LLPStartPreview" }
    },
    {
        "iamcco/markdown-preview.nvim",
        cmd = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" },
        ft = { "markdown" },
        build = function() vim.fn["mkdp#util#install"]() end,
        keys = {
            { "<leader>vm", "<cmd>MarkdownPreviewToggle<CR>" }
        }
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
        cmd = { "Gitsigns" },
        keys = {
            { "<leader>og",  "<cmd>Gitsigns toggle_linehl<CR>" },
            { "<leader>gb",  "<cmd>Gitsigns toggle_current_line_blame<CR>" },
            { "<leader>gx",  "<cmd>Gitsigns toggle_deleted<CR>" },
            { "<leader>gd",  "<cmd>Gitsigns diffthis<CR>" },
            { "<leader>gn",  "<cmd>Gitsigns next_hunk<CR>" },
            { "<leader>gc",  "<cmd>Gitsigns prev_hunk<CR>" },
            { "<leader>g+",  "<cmd>Gitsigns stage_hunk<CR>" },
            { "<leader>gs",  "<cmd>Gitsigns stage_buffer<CR>" },
            { "<leader>g#",  "<cmd>Gitsigns undo_stage_hunk<CR>" },
            { "<leader>grr", "<cmd>Gitsigns reset_hunk<CR>" },
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
        "gorbit99/codewindow.nvim",
        config = true,
        keys = {
            { "<leader>vc", "<cmd>lua require('codewindow').toggle_minimap()<CR>" },
        }
    },
    {
        "seandewar/nvimesweeper",
        cmd = "Nvimesweeper",
    },
    {
        "tpope/vim-fireplace",
        ft = "clojure",
        keys = {
            { "<localleader>ee", "<cmd>Eval<CR>" },
            { "<localleader>ef", "<cmd>%Eval<CR>" },
        }
    },
    {
        "sudormrfbin/cheatsheet.nvim",
        cmd = { "Cheatsheet", "CheatsheetEdit" },
        event = "BufReadPre cheatsheet.txt",
        opts = {
            bundled_cheatsheets = {
                enabled = { "default" }
            }
        },
        keys = {
            { "<leader>?", "<cmd>Cheatsheet<CR>" }
        }
    }
}
