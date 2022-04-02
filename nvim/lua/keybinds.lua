local h = require("helper")
vim.api.nvim_set_var("mapleader", " ")

-- Navigation
h.nnoremap("<leader>q", ":wqa<CR>")
h.noremap("B", "be")
h.noremap("H", "^")
h.noremap("L", "$")
h.noremap("<A-l>", ":TmuxNavigateRight<CR>")
h.noremap("<A-h>", ":TmuxNavigateLeft<CR>")
h.noremap("<A-j>", ":TmuxNavigateDown<CR>")
h.noremap("<A-k>", ":TmuxNavigateUp<CR>")
h.noremap("<A-,>", ":TmuxNavigatePrevious<CR>")
h.map("n", "<C-p>", "(len(system('git rev-parse')) ? ':Files' : ':GFiles --exclude-standard --others --cached').\"<CR>\"", { expr = true, noremap = true })

h.map("n", "<leader>ss", "<cmd><C-u>SessionSave<CR>", h.default_ops)
h.map("n", "<leader>sl", "<cmd><C-u>SessionLoad<CR>", h.default_ops)
h.nnoremap("<leader>fh", "<cmd>DashboardFindHistory<CR>")
h.nnoremap("<leader>tc", "<cmd>DashboardChangeColorscheme<CR>")
h.nnoremap("<leader>fa", "<cmd>DashboardFindWord<CR>")
h.nnoremap("<leader>fb", "<cmd>DashboardJumpMark<CR>")
h.nnoremap("<leader>cn", "<cmd>DashboardNewFile<CR>")
h.nnoremap("<leader>d", "<cmd>Dashboard<CR>")

-- Text Manipulation
h.nnoremap("X", "d")
h.nnoremap("XX", "dd")
h.xnoremap("X", "d")
h.nnoremap("+", "~")
h.nnoremap("Q", "@") --@ sucks

--LSP
h.nnoremap("gd", "<cmd>lua vim.lsp.buf.definition()<CR>")
h.nnoremap("gi", "<cmd>lua vim.lsp.buf.implementation()<CR>")
h.nnoremap("gu", "<cmd>lua vim.lsp.buf.incoming_calls()<CR>")
h.nnoremap("<C-Space>", "<cmd>lua vim.lsp.buf.code_action()<CR>")
h.nnoremap("<leader>rn", "<cmd>lua vim.lsp.buf.rename()<CR>")
h.nnoremap("<C-f>", "<cmd>lua vim.lsp.buf.formatting()<CR>")

h.nnoremap("<leader>g", "<cmd>Gitsigns toggle_linehl<CR>")
h.nnoremap("<leader>u", "<cmd>UrlView<CR>")

-- Buffers
h.nnoremap("<leader>l", ":bn<CR>")
h.nnoremap("<leader>h", ":bp<CR>")
h.nnoremap("<leader>c", ":cclose<CR>")

-- Quick saving
h.nnoremap("<leader>w", ":wa<CR>")

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

