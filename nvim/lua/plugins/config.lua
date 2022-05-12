local h = require('helper')
local config = {}

-- Lualine
require('lualine') .setup {
    sections = {
        lualine_a = {'mode'},
        lualine_b = {
            'branch',
            'diff',
            {
                'diagnostics',
                sources = { 'nvim_lsp' },
                sections = { 'error', 'warn', 'info' },
             }
        },
        lualine_c = {'filename', 'lsp_progress'},
        lualine_x = {
            -- require('auto-session-library').current_session_name,
            'encoding',
            'fileformat',
            'filetype'
        },
        lualine_y = {'progress'},
        lualine_z = {'location'}
    },
    extensions = {'fzf'},
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
vim.cmd[[let $FZF_DEFAULT_OPTS='--layout=reverse']]

-- presence.nvim aka unnessecary discord rich presence
require('presence'):setup {}

-- Vim Move
config.move_key_modifier = 'C'

-- Tmux
config.tmux_navigator_no_mappings = 1
config.tmux_navigator_save_on_switch = 2

h.glet(config)
