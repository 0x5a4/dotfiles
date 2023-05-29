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

local function vnoremap(bind, to)
    return vim.api.nvim_set_keymap("v", bind, to, default_ops)
end

local function xnoremap(bind, to)
    return vim.api.nvim_set_keymap("x", bind, to, default_ops)
end

vim.api.nvim_set_var("mapleader", " ")

--Really stupid, but otherwise FTerm breaks
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
noremap("<A-l>", ":TmuxNavigateRight<CR>")
noremap("<A-h>", ":TmuxNavigateLeft<CR>")
noremap("<A-j>", ":TmuxNavigateDown<CR>")
noremap("<A-k>", ":TmuxNavigateUp<CR>")
noremap("<A-,>", ":TmuxNavigatePrevious<CR>")
-- h.nnoremap("<leader>h", ":FSHere<CR>")

-- ugdb
-- h.nnoremap("<leader>b", "<cmd>UGDBBreakpoint<CR>")

-- Telescope
nnoremap("gs", "<cmd>Telescope lsp_document_symbols<CR>")
nnoremap("gi", "<cmd>Telescope lsp_incoming_calls<CR>")
nnoremap("gd", "<cmd>Telescope lsp_definitions<CR>")
nnoremap("<leader>s", "<cmd>Telescope spell_suggest<CR>")
nnoremap("<leader>e", "<cmd>Telescope diagnostics<CR>")
nnoremap("<leader>t", "<cmd>TodoTelescope<CR>")
nnoremap("<leader>gd", "<cmd>Telescope heading<CR>")
nnoremap("<leader>gc", "<cmd>Telescope git_commits<CR>")
nnoremap("<leader>gf", "<cmd>Telescope current_buffer_fuzzy_find<CR>")
nnoremap("<leader>/", "<cmd>Telescope live_grep<CR>")
nnoremap("<leader>u", "<cmd>Telescope undo<CR>")
nnoremap("<leader>vl", "<cmd>Telescope software-licenses find<CR>")
nnoremap("<C-M-p>", "<cmd>Telescope find_files<CR>")
vim.api.nvim_set_keymap("n", "<C-p>", "", {
    noremap = true,
    callback = function()
        local ok = pcall(require("telescope.builtin").git_files, {})
        if not ok then require("telescope.builtin").find_files({}) end
    end,
})

-- Text Manipulation
nnoremap("X", "d")
nnoremap("XX", "dd")
xnoremap("X", "d")
nnoremap("+", "~")
nnoremap("Q", "@") --@ sucks
nnoremap("<leader>+", "<cmd>ToggleAlternate<CR>")
nnoremap("<leader>p", '"+p')
nnoremap("<leader>y", '"+y')
nnoremap("go", "<cmd>call append(line('.'), repeat([''], v:count1))<CR>")
nnoremap("gO", "<cmd>call append(line('.')-1, repeat([''], v:count1))<CR>")

--LSP
nnoremap("<C-Space>", "<cmd>lua vim.lsp.buf.code_action()<CR>")
nnoremap("<leader>r", "<cmd>lua vim.lsp.buf.rename()<CR>")
nnoremap("<C-q>", "<cmd>lua vim.lsp.buf.hover()<CR>")
nnoremap("<C-f>", "<cmd>lua vim.lsp.buf.format({ async = true })<CR>")

nnoremap("<leader>og", "<cmd>Gitsigns toggle_linehl<CR>")
nnoremap("<leader>vu", "<cmd>UrlView<CR>")
nnoremap("<leader>oh", "<cmd>HexToggle<CR>")

-- Preview Stuff
nnoremap("<leader>vt", ":LLPStartPreview<CR>") -- LaTeX
nnoremap("<leader>vm", "<Plug>MarkdownPreviewToggle") -- Markdown

-- Buffers
nnoremap("<leader>l", ":bn<CR>")
nnoremap("<leader>h", ":bp<CR>")
nnoremap("<leader>C", ":bd<CR>")
nnoremap("<leader>c", "<cmd>Bdelete<CR>")

-- Spelling
nnoremap("<leader>os", ":set spell!<CR>")

-- Cellular Automaton
nnoremap("<leader>fml", "<cmd>CellularAutomaton make_it_rain<CR>")

-- Duck
nnoremap("<leader>dc", "<cmd>lua require('duck').cook()<CR>")
vim.keymap.set("n", "<leader>dd", function()
    local filetype = vim.bo.filetype;
    local d_u_c_k = {
        rust = "🦀",
        zig = "🦎",
    }
    require("duck").hatch(d_u_c_k[filetype] or "🦆")
end)

-- Stop using the f*cking arrow keys pleeeease
noremap(up, nop)
noremap(down, nop)
noremap(right, nop)
noremap(left, nop)
inoremap(up, nop)
inoremap(down, nop)
inoremap(right, nop)
inoremap(left, nop)

-- FTerm
vim.keymap.set('n', '<A-t>', '<CMD>lua require("FTerm").toggle()<CR>')
vim.keymap.set('t', '<A-t>', '<C-\\><C-n><CMD>lua require("FTerm").toggle()<CR>')

-- Venn
function _G.Toggle_venn()
    local venn_enabled = vim.inspect(vim.b.venn_enabled)
    if venn_enabled == "nil" then
        vim.b.venn_enabled = true
        vim.cmd [[setlocal ve=all]]
        -- draw a line on HJKL keystokes
        vim.api.nvim_buf_set_keymap(0, "n", "J", "<C-v>j:VBox<CR>", { noremap = true })
        vim.api.nvim_buf_set_keymap(0, "n", "K", "<C-v>k:VBox<CR>", { noremap = true })
        vim.api.nvim_buf_set_keymap(0, "n", "L", "<C-v>l:VBox<CR>", { noremap = true })
        vim.api.nvim_buf_set_keymap(0, "n", "H", "<C-v>h:VBox<CR>", { noremap = true })
        -- draw a box by pressing "f" with visual selection
        vim.api.nvim_buf_set_keymap(0, "v", "f", ":VBox<CR>", { noremap = true })
    else
        vim.cmd [[setlocal ve=]]
        vim.cmd [[mapclear <buffer>]]
        vim.b.venn_enabled = nil
    end
end

--toggle keymappings
vim.api.nvim_set_keymap('n', '<leader>ov', ":lua Toggle_venn()<CR>", { noremap = true, silent = true })
