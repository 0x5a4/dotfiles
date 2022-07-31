return function()
    require('lualine').setup {
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
    }
end

