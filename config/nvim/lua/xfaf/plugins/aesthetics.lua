return {
    {
        "Mofiqul/dracula.nvim",
        lazy = false,
        priority = 1000,
        config = function()
            vim.cmd([[colorscheme dracula]])
        end,
    },
    {
        "nvim-lualine/lualine.nvim",
        event = "VeryLazy",
        opts = {
            sections = {
                lualine_a = { 'mode' },
                lualine_b = {
                    'branch',
                    'diff',
                    {
                        'diagnostics',
                        sources = { 'nvim_lsp' },
                        sections = { 'error', 'warn', 'info' },
                    }
                },
                lualine_c = { "filename" },
                lualine_x = {
                    'encoding',
                    'fileformat',
                    'filetype'
                },
                lualine_y = { 'progress' },
                lualine_z = { 'location' }
            },
            options = {
                globalstatus = true,
                theme = 'dracula-nvim'
            }
        },
    },

    {
        "stevearc/dressing.nvim",
        config = {
            input = {
                relative = "editor",
            },
        },
        event = "VeryLazy"
    },
    {
        "h-hg/numbers.nvim",
        config = true
    },
    {
        "kyazdani42/nvim-web-devicons",
        config = true,
        event = "VeryLazy"
    },
    {
        "eandrju/cellular-automaton.nvim",
        keys = {
            { "<leader>fml", "<cmd>CellularAutomaton make_it_rain<CR>" },
        },
        cmd = "CellularAutomaton"
    },
    {
        "tamton-aquib/duck.nvim",
        keys = {
            { "<leader>fc", "<cmd>lua require('duck').cook()<CR>" },
            {
                "<leader>fd",
                "",
                callback = function()
                    local filetype = vim.bo.filetype;
                    local d_u_c_k = {
                        rust = "🦀",
                        zig = "🦎",
                        lua = "🌚",
                    }

                    local icon = d_u_c_k[filetype] or "🦆";

                    if math.random(5) == 1 then
                        icon = "ඞ";
                    end

                    require("duck").hatch(icon, 5)
                end
            }
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
            }
        }
    },
    {
        "j-hui/fidget.nvim",
        config = {
            notification = {
                override_vim_notify = true,
            },
        },
    },
    {
        "Aasim-A/scrollEOF.nvim",
        opts = {
            insert_mode = true,
        },
    },
    {
        'mcauley-penney/visual-whitespace.nvim',
        event = "User VisualEnter",
        opts = {
            space_char = " ",
        },
    }
}
