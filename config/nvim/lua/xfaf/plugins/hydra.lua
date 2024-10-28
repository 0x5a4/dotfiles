return {
    "nvimtools/hydra.nvim",
    keys = { "<c-w>" },
    config = function()
        local Hydra = require("hydra")

        Hydra {
            name = "Window Resize",
            body = "<c-w>",
            config = {
                timeout = 4000,
            },
            heads = {
                -- Resize
                { ">", "2<c-w>>", { desc = "increase width" } },
                { "<", "2<c-w><", { desc = "decrease width" } },
                { "+", "<c-w>+",  { desc = "increase height" } },
                { "-", "<c-w>-",  { desc = "decrease height" } },

                { "h", "<c-w>h" },
                { "j", "<c-w>j" },
                { "k", "<c-w>k" },
                { "l", "<c-w>l" },

                -- Exit
                { "q", nil,       { exit = true } },
            },
        }
    end,
}
