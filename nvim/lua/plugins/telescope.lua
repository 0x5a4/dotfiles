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
        tag = "0.1.1",
        config = function()
            local telescope = require("telescope")

            telescope.load_extension("heading")
            telescope.load_extension("undo")
            telescope.load_extension("software-licenses")
            telescope.load_extension("emoji")

            telescope.setup {
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
                            ["<esc>"] = "close"
                        },
                    }
                },
                pickers = {
                    spell_suggest = {
                        theme = "cursor",
                    }
                }
            }
        end
    },
}
