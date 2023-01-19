local h = {}
h.nop = "<nop>"
h.up = "<Up>"
h.down = "<Down>"
h.right = "<Right>"
h.left = "<Left>"
h.default_ops = { noremap = true, silent = true }

-- Key Mapping
function h.nnoremap(bind, to)
    return vim.api.nvim_set_keymap("n", bind, to, h.default_ops)
end

function h.noremap(bind, to)
    return vim.api.nvim_set_keymap("", bind, to, h.default_ops)
end

function h.inoremap(bind, to)
    return vim.api.nvim_set_keymap("i", bind, to, h.default_ops)
end

function h.vnoremap(bind, to)
    return vim.api.nvim_set_keymap("v", bind, to, h.default_ops)
end

function h.xnoremap(bind, to)
    return vim.api.nvim_set_keymap("x", bind, to, h.default_ops)
end

vim.api.nvim_set_var("mapleader", " ")

--Really stupid, but otherwise FTerm breaks
vim.keymap.set('n', '<leader>q', function()
    vim.cmd("wa")
    vim.cmd("qa")
end)

-- Quick saving
h.nnoremap("<leader>w", ":wa<CR>")

--Normal mode
vim.api.nvim_set_keymap("x", "kj", "<esc>", h.default_ops)
vim.api.nvim_set_keymap("x", "<esc>", h.nop, h.default_ops)

-- Navigation
h.noremap("B", "be")
h.noremap("H", "^")
h.noremap("K", "gg")
h.noremap("J", "G")
h.noremap("L", "$")
h.noremap("<A-l>", ":TmuxNavigateRight<CR>")
h.noremap("<A-h>", ":TmuxNavigateLeft<CR>")
h.noremap("<A-j>", ":TmuxNavigateDown<CR>")
h.noremap("<A-k>", ":TmuxNavigateUp<CR>")
h.noremap("<A-,>", ":TmuxNavigatePrevious<CR>")
-- h.nnoremap("<leader>h", ":FSHere<CR>")

h.nnoremap("<leader>j", "J")

-- ugdb
h.nnoremap("<leader>b", "<cmd>UGDBBreakpoint<CR>")

-- Telescope
h.nnoremap("<leader>s", "<cmd>Telescope spell_suggest<CR>")
h.nnoremap("<leader>e", "<cmd>Telescope diagnostics<CR>")
h.nnoremap("gs", "<cmd>Telescope lsp_document_symbols<CR>")
h.nnoremap("<leader>t", "<cmd>TodoTelescope<CR>")
h.nnoremap("<leader>gd", "<cmd>Telescope heading<CR>")
h.nnoremap("<leader>gc", "<cmd>Telescope git_commits<CR>")
h.nnoremap("<leader>gf", "<cmd>Telescope current_buffer_fuzzy_find<CR>")
h.nnoremap("<C-M-p>", "<cmd>Telescope find_files<CR>")
vim.api.nvim_set_keymap("n", "<C-p>", "", {
    noremap = true,
    callback = function()
        local ok = pcall(require("telescope.builtin").git_files, {})
        if not ok then require("telescope.builtin").find_files({}) end
    end,
})

-- Text Manipulation
h.nnoremap("X", "d")
h.nnoremap("XX", "dd")
h.xnoremap("X", "d")
h.nnoremap("+", "~")
h.nnoremap("Q", "@") --@ sucks
h.nnoremap("<leader>+", "<cmd>ToggleAlternate<CR>")
h.nnoremap("<leader>p", '"+p')
h.nnoremap("<leader>y", '"+y')

--LSP
h.nnoremap("gd", "<cmd>lua vim.lsp.buf.definition()<CR>")
h.nnoremap("gi", "<cmd>lua vim.lsp.buf.implementation()<CR>")
h.nnoremap("<C-Space>", "<cmd>lua vim.lsp.buf.code_action()<CR>")
h.nnoremap("<leader>r", "<cmd>lua vim.lsp.buf.rename()<CR>")
h.nnoremap("<C-f>", "<cmd>lua vim.lsp.buf.format({ async = true })<CR>")

h.nnoremap("<leader>og", "<cmd>Gitsigns toggle_linehl<CR>")
h.nnoremap("<leader>vu", "<cmd>UrlView<CR>")
h.nnoremap("<leader>oh", "<cmd>HexToggle<CR>")

-- Preview Stuff
h.nnoremap("<leader>vt", ":LLPStartPreview<CR>") -- LaTeX
h.nnoremap("<leader>vm", "<Plug>MarkdownPreviewToggle") -- Markdown

-- Buffers
h.nnoremap("<leader>l", ":bn<CR>")
h.nnoremap("<leader>h", ":bp<CR>")
h.nnoremap("<leader>C", ":bd<CR>")
h.nnoremap("<leader>c", "<cmd>Bdelete<CR>")

-- Spelling
h.nnoremap("<leader>os", ":set spell!<CR>")

-- Cellular Automaton
h.nnoremap("<leader>fml", "<cmd>CellularAutomaton make_it_rain<CR>")

-- Duck
h.nnoremap("<leader>dc", "<cmd>lua require('duck').cook()<CR>")
vim.keymap.set("n", "<leader>dd", function()
    local filetype = vim.bo.filetype;
    local d_u_c_k = {
        rust = "🦀",
        zig = "🦎",
    }
    require("duck").hatch(d_u_c_k[filetype] or "🦆")
end)

-- Stop using the f*cking arrow keys pleeeease
h.noremap(h.up, h.nop)
h.noremap(h.down, h.nop)
h.noremap(h.right, h.nop)
h.noremap(h.left, h.nop)
h.inoremap(h.up, h.nop)
h.inoremap(h.down, h.nop)
h.inoremap(h.right, h.nop)
h.inoremap(h.left, h.nop)

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

-- toggle keymappings
vim.api.nvim_set_keymap('n', '<leader>ov', ":lua Toggle_venn()<CR>", { noremap = true, silent = true })
