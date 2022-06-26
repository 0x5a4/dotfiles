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

function h.map(mode, bind, to, opts)
	return vim.keymap.set(mode, bind, to, opts)
end

vim.api.nvim_set_var("mapleader", " ")

--Really stupid, but otherwise FTerm breaks
vim.keymap.set('n', '<leader>q', function()
	vim.cmd("wa")
	vim.cmd("qa")
end)

--Normal mode
h.map("x", "kj", "<esc>", h.default_ops)
h.map("i", "kj", "<esc>", h.default_ops)
h.map("x", "<esc>", h.nop, h.default_ops)
h.map("i", "<esc>", h.nop, h.default_ops)

-- Navigation
h.noremap("B", "be")
h.noremap("H", "^")
h.noremap("L", "$")
h.noremap("<A-l>", ":TmuxNavigateRight<CR>")
h.noremap("<A-h>", ":TmuxNavigateLeft<CR>")
h.noremap("<A-j>", ":TmuxNavigateDown<CR>")
h.noremap("<A-k>", ":TmuxNavigateUp<CR>")
h.noremap("<A-,>", ":TmuxNavigatePrevious<CR>")
h.map("n", "<C-p>", "(len(system('git rev-parse')) ? ':Files' : ':GFiles --exclude-standard --others --cached').\"<CR>\""
	, { expr = true, noremap = true })

-- Text Manipulation
h.nnoremap("X", "d")
h.nnoremap("XX", "dd")
h.xnoremap("X", "d")
h.nnoremap("+", "~")
h.nnoremap("Q", "@") --@ sucks
h.nnoremap("<leader>ta", "<cmd>ToggleAlternate<CR>")

--LSP
h.nnoremap("gd", "<cmd>lua vim.lsp.buf.definition()<CR>")
h.nnoremap("gi", "<cmd>lua vim.lsp.buf.implementation()<CR>")
h.nnoremap("gu", "<cmd>lua vim.lsp.buf.incoming_calls()<CR>")
h.nnoremap("<C-Space>", "<cmd>lua vim.lsp.buf.code_action()<CR>")
h.nnoremap("<leader>rn", "<cmd>lua vim.lsp.buf.rename()<CR>")
h.nnoremap("<C-f>", "<cmd>lua vim.lsp.buf.formatting()<CR>")

h.nnoremap("<leader>gs", "<cmd>Gitsigns toggle_linehl<CR>")
h.nnoremap("<leader>u", "<cmd>UrlView<CR>")

--Markdown
h.map("n", "<leader>md", "<Plug>MarkdownPreviewToggle")
h.map("x", "<leader>md", "<Plug>MarkdownPreviewToggle")

-- Buffers
h.nnoremap("<leader>l", ":bn<CR>")
h.nnoremap("<leader>h", ":bp<CR>")
h.nnoremap("<leader>c", ":bd<CR>")

-- Quick saving
h.nnoremap("<leader>w", ":wa<CR>")

-- Spelling
h.nnoremap("<leader>s", ":set spell!<CR>")

-- Stop using the f*cking arrow keys pleeeease
h.noremap(h.up, h.nop)
h.noremap(h.down, h.nop)
h.noremap(h.right, h.nop)
h.noremap(h.left, h.nop)
h.inoremap(h.up, h.nop)
h.inoremap(h.down, h.nop)
h.inoremap(h.right, h.nop)
h.inoremap(h.left, h.nop)

h.nnoremap("ü", "{")
h.vnoremap("ü", "{")
h.nnoremap("ä", "}")
h.vnoremap("ä", "}")
