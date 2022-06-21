require('plugins')
require('options')
require('keybinds')

vim.cmd [[colorscheme sonokai]]

--ASM Filetype
vim.api.nvim_create_autocmd({ "BufNewFile", "BufRead" }, {
    pattern = "*.asm",
    command = "set ft=asm"
})

