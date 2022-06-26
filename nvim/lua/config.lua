local configmap = {}

--Gitsigns
configmap["gitsigns"] = function()
    require('gitsigns').setup {
        signcolumn = false,
        numhl = true,
        linehl = false,
    }
end

-- Fzf
vim.cmd [[let $FZF_DEFAULT_OPTS='--layout=reverse']]

-- Vim Move
configmap["vim-move"] = function()
    vim.g.move_key_modifier = 'C'
    vim.g.move_key_modifier_visualmode = 'C'
end

-- Tmux
configmap["vim-tmux"] = function()
    vim.g.tmux_navigator_no_mappings = 1
    vim.g.tmux_navigator_save_on_switch = 2
end

--vim-crates
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

--FTerm
configmap["fterm"] = function()
    require('FTerm').setup({
        border = 'rounded'
    })
    vim.keymap.set('n', '<A-t>', '<CMD>lua require("FTerm").toggle()<CR>')
    vim.keymap.set('t', '<A-t>', '<C-\\><C-n><CMD>lua require("FTerm").toggle()<CR>')
end

--Spellsitter
configmap["spellsitter"] = function()
    require('spellsitter').setup()
end

--Tabout
configmap["tabout"] = function()
    require('tabout').setup {
        completion = true
    }
end

configmap["treesitter"] = require("plugins.treesitter")
configmap["lspconfig"] = require("plugins.lsp")
configmap["nvim-cmp"] = require("plugins.nvimcmp")
configmap["lualine"] = require("plugins.lualine")

return configmap
