local h = require("helper")

--Config
local config = {}
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

h.glet(config)
