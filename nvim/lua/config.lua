local configmap = {}

-- gitsigns
configmap["gitsigns"] = function()
    require('gitsigns').setup {
        signcolumn = false,
        numhl = true,
        linehl = false,
    }
end

-- vim move
configmap["vim-move"] = function()
    vim.g.move_key_modifier = 'C'
    vim.g.move_key_modifier_visualmode = 'C'
end

-- tmux
configmap["vim-tmux"] = function()
    vim.g.tmux_navigator_no_mappings = 1
    vim.g.tmux_navigator_save_on_switch = 2
end

-- vim-crates
configmap["vim-crates"] = function()
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
end

-- fterm
configmap["fterm"] = function()
    require('FTerm').setup({
        border = 'rounded'
    })
    vim.keymap.set('n', '<A-t>', '<CMD>lua require("FTerm").toggle()<CR>')
    vim.keymap.set('t', '<A-t>', '<C-\\><C-n><CMD>lua require("FTerm").toggle()<CR>')
end

-- spellsitter
configmap["spellsitter"] = function()
    require('spellsitter').setup()
end

-- todo-comments
configmap["todo-comments"] = function()
    require("todo-comments").setup {}
end

-- nvim-colorizer
configmap["colorizer"] = function()
    require("colorizer").setup {}
end

-- better-escape
configmap["better-escape"] = function()
    require("better_escape").setup {
        mapping = { "kj" },
        timeout = 500,
        clear_empty_lines = true,
    }
end

configmap["treesitter"] = require("plugins.treesitter")
configmap["lspconfig"] = require("plugins.lsp")
configmap["nvim-cmp"] = require("plugins.nvimcmp")
configmap["lualine"] = require("plugins.lualine")
configmap["telescope"] = require("plugins.telescope")
configmap["hydra"] = require("plugins.hydra")

return configmap
