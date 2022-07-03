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

--Normal mode
vim.api.nvim_set_keymap("x", "kj", "<esc>", h.default_ops)
vim.api.nvim_set_keymap("x", "<esc>", h.nop, h.default_ops)

-- Navigation
h.noremap("B", "be")
h.noremap("H", "^")
h.noremap("L", "$")
h.noremap("<A-l>", ":TmuxNavigateRight<CR>")
h.noremap("<A-h>", ":TmuxNavigateLeft<CR>")
h.noremap("<A-j>", ":TmuxNavigateDown<CR>")
h.noremap("<A-k>", ":TmuxNavigateUp<CR>")
h.noremap("<A-,>", ":TmuxNavigatePrevious<CR>")

-- Telescope
vim.api.nvim_set_keymap("n", "<C-p>", "", {
	noremap = true,
	callback = function()
		local ok = pcall(require("telescope.builtin").git_files, {})
		if not ok then require("telescope.builtin").find_files({}) end
	end,
})
h.nnoremap("<leader>d", "<cmd>Telescope lsp_document_symbols<CR>")
h.nnoremap("<leader>s", "<cmd>Telescope spell_suggest<CR>")
h.nnoremap("<leader>e", "<cmd>Telescope diagnostics<CR>")
h.nnoremap("<leader>t", "<cmd>TodoTelescope<CR>")
h.nnoremap("<leader>gh", "<cmd>Telescope heading<CR>")

-- Text Manipulation
h.nnoremap("X", "d")
h.nnoremap("XX", "dd")
h.xnoremap("X", "d")
h.nnoremap("+", "~")
h.nnoremap("Q", "@") --@ sucks
h.nnoremap("<leader>+", "<cmd>ToggleAlternate<CR>")

--LSP
h.nnoremap("gd", "<cmd>lua vim.lsp.buf.definition()<CR>")
h.nnoremap("gi", "<cmd>lua vim.lsp.buf.implementation()<CR>")
h.nnoremap("gu", "<cmd>lua vim.lsp.buf.incoming_calls()<CR>")
h.nnoremap("<C-Space>", "<cmd>lua vim.lsp.buf.code_action()<CR>")
h.nnoremap("<leader>rn", "<cmd>lua vim.lsp.buf.rename()<CR>")
h.nnoremap("<C-f>", "<cmd>lua vim.lsp.buf.formatting()<CR>")

h.nnoremap("<leader>og", "<cmd>Gitsigns toggle_linehl<CR>")
h.nnoremap("<leader>u", "<cmd>UrlView<CR>")

--Markdown
vim.api.nvim_set_keymap("n", "<leader>md", "<Plug>MarkdownPreviewToggle", h.default_ops)
vim.api.nvim_set_keymap("x", "<leader>md", "<Plug>MarkdownPreviewToggle", h.default_ops)

-- Buffers
h.nnoremap("<leader>l", ":bn<CR>")
h.nnoremap("<leader>h", ":bp<CR>")
h.nnoremap("<leader>C", ":bd<CR>")
h.nnoremap("<leader>c", "<cmd>NeoNoName<CR>")

-- Quick saving
h.nnoremap("<leader>w", ":wa<CR>")

-- Spelling
h.nnoremap("<leader>os", ":set spell!<CR>")

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

-- toggle keymappings for venn using <leader>v
vim.api.nvim_set_keymap('n', '<leader>v', ":lua Toggle_venn()<CR>", { noremap = true, silent = true})
