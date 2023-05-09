return {
    {
        "nvim-telescope/telescope.nvim",
        dependencies = "nvim-lua/plenary.nvim",
        config = function()
            local telescope = require("telescope")
            
            telescope.load_extension("heading")

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
    "crispgm/telescope-heading.nvim"
}
