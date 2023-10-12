return {
    {
        "nvim-telescope/telescope.nvim",
        dependencies = { -- PLUGINS ARE HERE, TAKE A CLOSER LOOK
            "nvim-lua/plenary.nvim",
            "crispgm/telescope-heading.nvim",
            "debugloop/telescope-undo.nvim",
            "chip/telescope-software-licenses.nvim",
            "crispgm/telescope-heading.nvim",
            "xiyaowong/telescope-emoji.nvim"
        },
        cmd = "Telescope",
        tag = "0.1.4",
        keys = {
            { "gi",         "<cmd>Telescope lsp_incoming_calls<CR>" },
            { "gd",         "<cmd>Telescope lsp_definitions<CR>" },
            { "<leader>s",  "<cmd>Telescope lsp_document_symbols<CR>" },
            { "<leader>e",  "<cmd>Telescope diagnostics<CR>" },
            { "<leader>gs", "<cmd>Telescope spell_suggest<CR>" },
            { "<leader>gd", "<cmd>Telescope heading<CR>" },
            { "<leader>gc", "<cmd>Telescope git_commits<CR>" },
            { "<leader>gf", "<cmd>Telescope current_buffer_fuzzy_find<CR>" },
            { "<leader>7",  "<cmd>Telescope live_grep<CR>" },
            { "<leader>u",  "<cmd>Telescope undo<CR>" },
            { "<leader>vl", "<cmd>Telescope software-licenses find<CR>" },
            { "<leader>ve", "<cmd>Telescope emoji<CR>" },
            {
                "<C-M-p>",
                "",
                callback = function()
                    require("telescope.builtin").find_files({
                        hidden = true,
                        no_ignore = true,
                        no_parent_ignore = true,
                    })
                end
            },
            {
                "<C-p>",
                "",
                noremap = true,
                callback = function()
                    local ok = pcall(require("telescope.builtin").git_files, {})
                    if not ok then require("telescope.builtin").find_files({}) end
                end
            },
        },
        opts = {
            defaults = {
                layout_config = {
                    horizontal = {
                        prompt_position = "top",
                    },
                },
                sorting_strategy = 'ascending',
                mappings = {
                    i = {
                        ["<C-j>"] = "move_selection_next",
                        ["<C-k>"] = "move_selection_previous",
                        ["<esc>"] = "close",
                        ["<C-q>"] = "close",
                    },
                    n = {
                        ["q"] = "close",
                    }
                }
            },
            pickers = {
                spell_suggest = {
                    theme = "cursor",
                }
            }
        },
        config = function(_, opts)
            local telescope = require("telescope")

            telescope.load_extension("heading")
            telescope.load_extension("undo")
            telescope.load_extension("software-licenses")
            telescope.load_extension("emoji")

            telescope.setup(opts)
        end
    },
}
