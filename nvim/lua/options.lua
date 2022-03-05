local opt = vim.opt

opt.number = true
opt.undofile = true
opt.wildmenu = true
opt.wildignore = "*/.git/,*/Cargo.lock,*/pubspec.lock"
opt.splitright = true

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

-- for emails
vim.cmd [[au BufRead /tmp/neomutt-* set tw=72]]