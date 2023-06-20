return {
    {
        "sainnhe/sonokai",
        lazy = false,
        priority = 1000,
        config = function()
            vim.cmd([[colorscheme sonokai]])
        end,
    },
    {
        "nvim-lualine/lualine.nvim",
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
                lualine_c = { 'filename' },
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
            }
        },
    },

    {
        "stevearc/dressing.nvim",
        config = true
    },
    {
        "h-hg/numbers.nvim",
        config = true
    },
    "kyazdani42/nvim-web-devicons",
    {
        "eandrju/cellular-automaton.nvim",
        lazy = true,
        cmd = "CellularAutomaton"
    },
    {
        "tamton-aquib/duck.nvim",
        lazy = true
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
        tag = "legacy"
    }
}
