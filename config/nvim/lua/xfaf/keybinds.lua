local nop = "<nop>"
local up = "<Up>"
local down = "<Down>"
local right = "<Right>"
local left = "<Left>"
local default_ops = { noremap = true, silent = true }

-- Key Mapping
local function nnoremap(bind, to)
    return vim.api.nvim_set_keymap("n", bind, to, default_ops)
end

local function noremap(bind, to)
    return vim.api.nvim_set_keymap("", bind, to, default_ops)
end

local function inoremap(bind, to)
    return vim.api.nvim_set_keymap("i", bind, to, default_ops)
end

local function xnoremap(bind, to)
    return vim.api.nvim_set_keymap("x", bind, to, default_ops)
end

vim.api.nvim_set_var("mapleader", " ")
vim.api.nvim_set_var("maplocalleader", ",")

-- Really stupid, but otherwise FTerm breaks
vim.keymap.set('n', '<leader>q', function()
    vim.cmd("wa")
    vim.cmd("qa")
end)

-- Quick saving
nnoremap("<leader>w", ":wa<CR>")

--Normal mode
vim.api.nvim_set_keymap("x", "kj", "<esc>", default_ops)
vim.api.nvim_set_keymap("x", "<esc>", nop, default_ops)

-- Navigation
noremap("H", "^")
noremap("L", "$")
-- ugdb
-- h.nnoremap("<leader>b", "<cmd>UGDBBreakpoint<CR>")

-- Text Manipulation
nnoremap("X", "d")
nnoremap("XX", "dd")
xnoremap("X", "d")
nnoremap("+", "~")
nnoremap("Q", "@") --@ sucks
nnoremap("<leader>p", '"+p')
nnoremap("<leader>y", '"+y')
xnoremap("<leader>y", '"+y')
nnoremap("go", "<cmd>call append(line('.'), repeat([''], v:count1))<CR>")
nnoremap("gO", "<cmd>call append(line('.')-1, repeat([''], v:count1))<CR>")

--LSP
nnoremap("<C-Space>", "<cmd>lua vim.lsp.buf.code_action()<CR>")
nnoremap("<leader>r", "<cmd>lua vim.lsp.buf.rename()<CR>")
nnoremap("<C-q>", "<cmd>lua vim.lsp.buf.hover()<CR>")
nnoremap("<C-f>", "<cmd>lua vim.lsp.buf.format({ async = true })<CR>")

-- Buffers
nnoremap("<leader>l", ":bn<CR>")
nnoremap("<leader>h", ":bp<CR>")
nnoremap("<leader>C", ":bd<CR>")

-- Spelling
nnoremap("<leader>os", ":set spell!<CR>")

-- Stop using the f*cking arrow keys pleeeease
noremap(up, nop)
noremap(down, nop)
noremap(right, nop)
noremap(left, nop)
inoremap(up, nop)
inoremap(down, nop)
inoremap(right, nop)
inoremap(left, nop)
