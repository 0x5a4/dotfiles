return {
    {
        "nvim-neorg/neorg",
        ft = "norg",
        cmd = { "Neorg" },
        dependencies = { "luarocks.nvim" },
        lazy = false,
        version = "*",
        config = function()
            require("neorg").setup {
                load = {
                    ["core.defaults"] = {}, -- Loads default behaviour
                    ["core.completion"] = {
                        config = {
                            engine = "nvim-cmp",
                        }
                    },
                    ["core.concealer"] = {}, -- Adds pretty icons to your documents
                    ["core.dirman"] = {      -- Manages Neorg workspaces
                        config = {
                            workspaces = {
                                brian = "~/brian",
                            },
                            default_workspace = "brian"
                        },
                    },
                },
            }
        end,
    },
}
