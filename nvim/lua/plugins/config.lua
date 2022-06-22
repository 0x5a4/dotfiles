local h = require('helper')
local config = {}

-- Lualine
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
        lualine_c = { 'filename', 'lsp_progress' },
        lualine_x = {
            'encoding',
            'fileformat',
            'filetype'
        },
        lualine_y = { 'progress' },
        lualine_z = { 'location' }
    },
    extensions = { 'fzf' },
    options = {
        globalstatus = true,
    }
}

--Gitsigns
require('gitsigns').setup {
    signcolumn = false,
    numhl = true,
    linehl = false,
}

-- Fzf
vim.cmd [[let $FZF_DEFAULT_OPTS='--layout=reverse']]

-- presence.nvim aka unnessecary discord rich presence
require('presence'):setup {}

-- Vim Move
config.move_key_modifier = 'C'
config.move_key_modifier_visualmode = 'C'

-- Tmux
config.tmux_navigator_no_mappings = 1
config.tmux_navigator_save_on_switch = 2

--vim-crates
vim.api.nvim_create_autocmd({ "BufNewFile", "BufRead" }, {
    pattern = { "Cargo.toml" },
    callback = function()
        vim.cmd([[
            highlight clear Crates
            highlight link Crates InfoFloat
        ]])
        vim.cmd([[call crates#toggle()]])
    end
})

--FTerm
require('FTerm').setup({
    border = 'rounded'
})
vim.keymap.set('n', '<A-t>', '<CMD>lua require("FTerm").toggle()<CR>')
vim.keymap.set('t', '<A-t>', '<C-\\><C-n><CMD>lua require("FTerm").toggle()<CR>')

h.glet(config)
