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
        config = true,
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
        config = true,
        tag = "legacy",
        event = "VeryLazy"
    },
    {
        "rcarriga/nvim-notify",
        config = function()
            vim.notify = require("notify")
        end
    },
    {
        "folke/zen-mode.nvim",
        cmd = "ZenMode",
        keys = {
            { "<leader>oz", "<cmd>ZenMode<CR>" },
        },
        config = function(opts)
            require("zen-mode").setup({
                window = {
                    backdrop = 1,
                },
                plugins = {
                    tmux = {
                        enabled = true,
                    }
                },
                on_open = function()
                    require("oogway").sense_the_dragon_warrior()
                end
            })

            vim.api.nvim_create_autocmd({ "VimLeave" }, {
                callback = function()
                    require("zen-mode").close()
                end,
            })
        end,
    },
    {
        "Aasim-A/scrollEOF.nvim",
        opts = {
            insert_mode = true,
        },
    },
    {
        "0x5a4/oogway.nvim",
        cmd = { "Oogway" },
    },
    {
        "nvimdev/dashboard-nvim",
        config = function()
            local oogway = require("oogway")
            require("dashboard").setup({
                config = {
                    header = vim.fn.split(oogway.inspire_me(), "\n"),
                    footer = { oogway.what_is_your_wisdom() },
                }
            })
        end
    }
}
