local h = require('helper')
local config = {}

-- Airline
config.airline_theme = 'sonokai'

-- Vimsence
config.vimsence_small_text = 'NeoVim'
config.vimsence_small_image = 'neovim'

-- Vim Move
config.move_key_modifier = 'C'

-- Tmux
config.tmux_navigator_no_mappings = 1
config.tmux_navigator_save_on_switch = 2

--Dashboard
config.dashboard_default_executive = "fzf"
config.dashboard_custom_shortcut = {
    ["last_session"] = 'SPC s l',
    ["find_history"] = 'SPC f h',
    ["find_file"] = '<C-p>',
    ["new_file"] = 'SPC c n',
    ["change_colorscheme"] = 'SPC t c',
    ["find_word"] = 'SPC f a',
    ["book_marks"] = 'SPC f b',
}

--AutoPairs
config.AutoPairs = {
    ["("] = ")",
    ["{"] = "}",
    ["["] = "]",
    ["<"] = ">",
    ["'"] = "'",
    ['"'] = '"',
    ["`"] = "`",
    ["```"] = "```",
}

h.glet(config)

h.autocmd.BufRead = {
    "Cargo.toml",
    function() vim.api.nvim_call_function("crates#toggle", {}) end
}
