require("xfaf.keybinds")
require("xfaf.options")

-- bootstrap lazy
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
    vim.fn.system({
        "git",
        "clone",
        "--filter=blob:none",
        "https://github.com/folke/lazy.nvim.git",
        "--branch=stable", -- latest stable release
        lazypath,
    })
end

vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
    spec = "xfaf.plugins",
    ui = {
        border = "rounded",
        backdrop = 100,
    },
    install = {
        colorscheme = { "tokyonight-night" },
    },
    dev = {
        path = "~/src",
        fallback = true,
    },
    change_detection = {
        notify = false,
    },
})
