return {
    {
        "folke/tokyonight.nvim",
        priority = 1000,
        opts = {
            style = "night",
            transparent = true,
        },
        config = function()
            vim.cmd([[colorscheme tokyonight-night]])
        end,
        lazy = false,
    },
    {
        "nvim-lualine/lualine.nvim",
        opts = {
            sections = {
                lualine_a = { "mode" },
                lualine_b = {
                    "branch",
                    "diff",
                    {
                        "diagnostics",
                        sources = { "nvim_lsp" },
                        sections = { "error", "warn", "info" },
                    },
                },
                lualine_c = { "filename" },
                lualine_x = {
                    "encoding",
                    "fileformat",
                    "filetype",
                },
                lualine_y = { "progress" },
                lualine_z = { "location" },
            },
            options = {
                globalstatus = true,
                theme = "tokyonight",
            },
        },
    },

    {
        "stevearc/dressing.nvim",
        event = "VeryLazy",
        opts = {
            input = {
                relative = "editor",
            },
        },
    },
    {
        "h-hg/numbers.nvim",
        event = "VeryLazy",
        config = true,
    },
    {
        "kyazdani42/nvim-web-devicons",
        lazy = true,
        config = true,
    },
    {
        "eandrju/cellular-automaton.nvim",
        keys = {
            { "<leader>fml", "<cmd>CellularAutomaton make_it_rain<CR>" },
        },
        cmd = "CellularAutomaton",
    },
    {
        "tamton-aquib/duck.nvim",
        keys = {
            { "<leader>fc", "<cmd>lua require('duck').cook()<CR>" },
            {
                "<leader>fd",
                "",
                callback = function()
                    local filetype = vim.bo.filetype
                    local d_u_c_k = {
                        rust = "🦀",
                        zig = "🦎",
                        lua = "🌚",
                    }

                    local icon = d_u_c_k[filetype] or "🦆"

                    if math.random(5) == 1 then
                        icon = "ඞ"
                    end

                    require("duck").hatch(icon, 5)
                end,
            },
        },
    },
    {
        "akinsho/bufferline.nvim",
        version = "*",
        dependencies = "kyazdani42/nvim-web-devicons",
        opts = {
            options = {
                show_close_icon = false,
                show_buffer_close_icons = false,
            },
        },
    },
    {
        "j-hui/fidget.nvim",
        config = true,
        event = "LspAttach",
        init = function()
            vim.notify = function(msg, level, opts)
                require("fidget").notify(msg, level, opts)
            end
        end,
    },
    {
        "Aasim-A/scrollEOF.nvim",
        event = "VeryLazy",
        opts = {
            insert_mode = true,
        },
    },
    {
        "mcauley-penney/visual-whitespace.nvim",
        event = "User VisualEnter",
        opts = {
            space_char = " ",
        },
    },
}
