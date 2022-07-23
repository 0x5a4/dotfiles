local opt = vim.opt

opt.number = true
opt.relativenumber = true
opt.undofile = true
opt.wildmenu = true
opt.wildignore = "*/.git/,*/Cargo.lock,*/pubspec.lock"
opt.splitright = true
opt.signcolumn = "yes"
opt.laststatus = 3
opt.timeoutlen = 500

-- Tabs
opt.expandtab = true
opt.shiftround = true
opt.shiftwidth = 4
opt.tabstop = 4

-- Display
opt.termguicolors = true
opt.lazyredraw = false
opt.scrolloff = 10
opt.autoread = true
opt.virtualedit = "block"

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
    pattern = "/*/nvim/*/*",
    command = "source <afile> | PackerCompile"
})

-- automatically activate spelling in MARKDOWN
vim.api.nvim_create_autocmd({ "BufNewFile", "BufRead" }, {
    pattern = "*.md",
    command = "set spell"
})
