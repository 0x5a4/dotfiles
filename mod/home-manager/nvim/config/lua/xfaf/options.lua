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
opt.swapfile = false
opt.cursorline = true
opt.cursorlineopt = "number"

-- Tabs
opt.expandtab = true
opt.shiftround = true
opt.shiftwidth = 4
opt.tabstop = 4

-- Display
opt.termguicolors = true
opt.lazyredraw = false
opt.scrolloff = 15
opt.autoread = true
opt.virtualedit = "block"

-- Searching & Folding
opt.ignorecase = true
opt.smartcase = true
opt.hlsearch = false
opt.foldenable = true
opt.foldmethod = "marker"

-- Conceal
opt.conceallevel = 1
opt.concealcursor = "c"

-- Variables
vim.g.tex_flavor = "latex"

-- for emails
vim.api.nvim_create_autocmd("BufRead", {
    pattern = "/tmp/neomutt-*",
    command = "set tw=72",
})

vim.api.nvim_create_autocmd("BufWinEnter", {
    group = vim.api.nvim_create_augroup("help_window_right", {}),
    pattern = { "*.txt", "*.norg" },
    callback = function()
        local filename = vim.fn.expand("%:t")

        if vim.o.filetype == "help" then
            vim.cmd.wincmd("L")
        elseif vim.fn.expand("%:p:h:t") == "doc" and
            filename == "breaking-changes.norg" or
            filename == "cheatsheet.norg" or
            filename == "neorg.norg" then
            vim.cmd.wincmd("L")
        end
    end,
})

local visual_event = vim.api.nvim_create_augroup("VisualEvent", {})

vim.api.nvim_create_autocmd({ "ModeChanged" }, {
    group = visual_event,
    pattern = "*:[vV\x16]*",
    callback = function()
        vim.api.nvim_exec_autocmds("User", {
            pattern = "VisualEnter",
            modeline = false,
        })
    end,
})

vim.api.nvim_create_autocmd({ "ModeChanged" }, {
    group = visual_event,
    pattern = "[vV\x16]*:*",
    callback = function()
        vim.api.nvim_exec_autocmds("User", {
            pattern = "VisualLeave",
            modeline = false,
        })
    end,
})

-- copy-pastad from astronvim
local file_event = vim.api.nvim_create_augroup("UserFileEvents", {})

local function runcmd(cmd, show_error)
    if type(cmd) == "string" then cmd = { cmd } end

    if vim.fn.has "win32" == 1 then cmd = vim.list_extend({ "cmd.exe", "/C" }, cmd) end

    local result = vim.fn.system(cmd)
    local success = vim.api.nvim_get_vvar "shell_error" == 0
    if not success and (show_error == nil or show_error) then
        vim.api.nvim_err_writeln(("Error running command %s\nError message:\n%s"):format(table.concat(cmd, " "), result))
    end

    return success and result:gsub("[\27\155][][()#;?%d]*[A-PRZcf-ntqry=><~]", "") or nil
end

vim.api.nvim_create_autocmd({ "BufReadPost", "BufNewFile", "BufWritePost" }, {
    group = file_event,
    callback = function(args)
        if not (vim.fn.expand "%" == "" or vim.api.nvim_get_option_value("buftype", { buf = args.buf }) == "nofile") then
            vim.api.nvim_exec_autocmds("User", {
                pattern = "File",
                modeline = false,
            })
            if
                runcmd({ "git", "-C", vim.fn.expand "%:p:h", "rev-parse" }, false)
            then
                vim.api.nvim_exec_autocmds("User", {
                    pattern = "GitFile",
                    modeline = false,
                })
                vim.api.nvim_del_augroup_by_name("UserFileEvents")
            end
        end
    end,
})
