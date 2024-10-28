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
            { "<leader>c", "<cmd>Bdelete<CR>" },
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
        } },
    },
    {
        "max397574/better-escape.nvim",
        event = "InsertEnter",
        tag = "v1.0.0",
        opts = {
            mapping = { "kj" },
            timeout = 500,
            clear_empty_lines = true,
        },
    },
    {
        "lervag/vimtex",
        init = function()
            vim.g.vimtex_view_method = "zathura"
            vim.g.vimtex_quickfix_mode = 0
            vim.g.tex_conceal = "abdmg"
            vim.g.vimtex_syntax_conceal = {
                accents = 1,
                cites = 1,
                fancy = 1,
                greek = 1,
                ligatures = 1,
                math_delimiters = 1,
                math_super_sub = 1,
                math_symbols = 1,
                spacing = 1,
                styles = 1,
                math_bounds = 0,
                math_fracs = 0,
                sections = 0,
            }
        end,
        lazy = false,
        keys = {
            { "<leader>vt", "<cmd>VimtexCompile<CR>" },
        },
    },
    {
        "numToStr/FTerm.nvim",
        lazy = true,
        keys = {
            { "<A-t>", '<cmd>lua require("FTerm").toggle()<CR>' },
            { "<A-t>", '<C-\\><C-n><CMD>lua require("FTerm").toggle()<CR>', mode = { "t" } },
        },
        opts = {
            border = "rounded",
        },
    },
    {
        "lewis6991/gitsigns.nvim",
        dependencies = "nvim-lua/plenary.nvim",
        event = "User GitFile",
        cmd = { "Gitsigns" },
        keys = {
            { "<leader>og",  "<cmd>Gitsigns toggle_linehl<CR>" },
            { "<leader>gb",  "<cmd>Gitsigns blame<CR>" },
            { "<leader>gx",  "<cmd>Gitsigns toggle_deleted<CR>" },
            { "<leader>gj",  "<cmd>Gitsigns next_hunk<CR>" },
            { "<leader>gk",  "<cmd>Gitsigns prev_hunk<CR>" },
            { "<leader>g+",  "<cmd>Gitsigns stage_hunk<CR>" },
            { "<leader>gs",  "<cmd>Gitsigns stage_buffer<CR>" },
            { "<leader>g#",  "<cmd>Gitsigns undo_stage_hunk<CR>" },
            { "<leader>grr", "<cmd>Gitsigns reset_hunk<CR>" },
        },
        opts = {
            signcolumn = false,
            numhl = true,
            linehl = false,
        },
    },
    {
        "akinsho/git-conflict.nvim",
        version = "*",
        event = "User GitFile",
        opts = {
            default_mappings = false,
        },
        keys = {
            { "<leader>gck", "<cmd>GitConflictPrevConflict<CR>" },
            { "<leader>gcj", "<cmd>GitConflictNextConflict<CR>" },
            { "<leader>gco", "<cmd>GitConflictChooseOurs<CR>" },
            { "<leader>gct", "<cmd>GitConflictChooseTheirs<CR>" },
        },
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
        "tpope/vim-fireplace",
        ft = "clojure",
        keys = {
            { "<localleader>ee", "<cmd>Eval<CR>" },
            { "<localleader>ef", "<cmd>%Eval<CR>" },
        },
    },
    {
        "sudormrfbin/cheatsheet.nvim",
        cmd = { "Cheatsheet", "CheatsheetEdit" },
        event = "BufReadPre cheatsheet.txt",
        opts = {
            bundled_cheatsheets = {
                enabled = { "default" },
            },
        },
        keys = {
            { "<leader>?", "<cmd>Cheatsheet<CR>" },
        },
    },
    {
        "laytan/cloak.nvim",
        cmd = { "CloakToggle", "CloakPreviewLine" },
        event = { "BufReadPre .env*", "BufNewFile .env*" },
        keys = {
            { "<leader>oc", "<cmd>CloakToggle<CR>" },
        },
        opts = {
            enabled = true,
            cloak_telescope = true,
            cloak_length = 12,
        },
    },
    {
        "xiyaowong/link-visitor.nvim",
        opts = {
            skip_confirmation = true,
        },
        cmd = {
            "VisitLinkInBuffer",
            "VisitLinkUnderCursor",
            "VisitLinkNearCursor",
            "VisitLinkNearest" },
        keys = {
            { "<leader>tu", "<cmd>VisitLinkInBuffer<CR>" },
            { "gu",         "<cmd>VisitLinkUnderCursor<CR>" },
        },
    },
}
