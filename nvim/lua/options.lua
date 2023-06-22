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
opt.mouse = ""
opt.swapfile = false

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

-- Variables
vim.g.tex_flavor = "latex"
vim.g.zig_fmt_autosave = 0

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

-- automatically activate spelling in MARKDOWN
vim.api.nvim_create_autocmd({ "BufNewFile", "BufRead" }, {
    pattern = "*.md",
    command = "setlocal spell"
})

vim.api.nvim_create_autocmd({ "FileType" }, { pattern = "zig", callback = function()
    vim.api.nvim_buf_set_option(0, "commentstring", "// %s")
end })
