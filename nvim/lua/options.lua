local opt = vim.opt

opt.number = true
opt.undofile = true
opt.wildmenu = true
opt.wildignore = "*/.git/,*/Cargo.lock,*/pubspec.lock"
opt.splitright = true
opt.signcolumn = "yes"
opt.laststatus = 3

-- Tabs
opt.expandtab = true
opt.shiftround = true
opt.shiftwidth = 4
opt.tabstop = 4

-- Display
opt.termguicolors = true
opt.lazyredraw = true
opt.scrolloff = 10
opt.autoread = true

-- Searching & Folding
opt.ignorecase = true
opt.smartcase = true
opt.hlsearch = false
opt.foldenable = true
opt.foldmethod = "marker"

--Autocommands

-- for emails
vim.api.nvim_create_autocmd("BufRead", {
    pattern = "/tmp/neomutt-*",
    command = "set tw=72"
})

-- ASM filetype
vim.api.nvim_create_autocmd({ "BufNewFile", "BufRead" }, {
    pattern = "*.asm",
    command = "set ft=asm"
})

-- auto recompile packer
vim.api.nvim_create_autocmd({ "BufWritePost" }, {
    pattern = "plugins.lua",
    command = "source <afile> | PackerCompile"
})
