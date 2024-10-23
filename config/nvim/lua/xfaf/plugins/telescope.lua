return {
    {
        "nvim-telescope/telescope.nvim",
        dependencies = { -- PLUGINS ARE HERE, TAKE A CLOSER LOOK
            "nvim-lua/plenary.nvim",
            "crispgm/telescope-heading.nvim",
            "nvim-telescope/telescope-symbols.nvim",
        },
        cmd = "Telescope",
        keys = {
            { "<leader>ts", "<cmd>Telescope lsp_document_symbols<CR>" },
            { "<leader>te", "<cmd>Telescope diagnostics<CR>" },
            { "<leader>tq", "<cmd>Telescope spell_suggest<CR>" },
            { "<leader>td", "<cmd>Telescope heading<CR>" },
            { "<leader>tc", "<cmd>Telescope git_commits<CR>" },
            { "<leader>tf", "<cmd>Telescope current_buffer_fuzzy_find<CR>" },
            { "<leader>tg", "<cmd>Telescope live_grep<CR>" },
            { "<leader>tz", "<cmd>Telescope symbols<CR>" },
            { "gi",         "<cmd>Telescope lsp_incoming_calls<CR>" },
            { "gd",         "<cmd>Telescope lsp_definitions<CR>" },
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
            },
        },
        config = function(_, opts)
            local telescope = require("telescope")

            telescope.load_extension("heading")

            telescope.setup(opts)
        end
    },
    {
        "folke/todo-comments.nvim",
        event = "User File",
        keys = {
            { "<leader>tt", "<cmd>TodoTelescope<CR>" },
        },
        dependencies = "nvim-lua/plenary.nvim",
        config = true
    },
}
