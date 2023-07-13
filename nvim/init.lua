require("xfaf.keybinds")
require("xfaf.options")

-- boobstrap lazy
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

-- If opening from inside neovim terminal then do not load all the other plugins
if os.getenv("NVIM") ~= nil then
    require('lazy').setup {
        { 'willothy/flatten.nvim', config = true },
    }
    return
end

require("lazy").setup({
    spec = "xfaf.plugins",
    ui = {
        border = "rounded"
    },
    install = {
        colorscheme = { "dracula" },
    },
})
