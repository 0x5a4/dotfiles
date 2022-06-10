T = {}
T.nop = "<nop>"
T.up = "<Up>"
T.down = "<Down>"
T.right = "<Right>"
T.left = "<Left>"
T.default_ops = { noremap = true, silent = true }

-- Globally assign variables
function T.glet(vars, to)
	if type(vars) == "table" then
		for k,v in pairs(vars) do
			vim.api.nvim_set_var(tostring(k), v)
		end
	else
		vim.api.nvim_set_var(tostring(vars), to)
	end
end

-- Key Mapping
function T.nnoremap(bind, to)
	return vim.api.nvim_set_keymap("n", bind, to, T.default_ops)
end

function T.noremap(bind, to)
	return vim.api.nvim_set_keymap("", bind, to, T.default_ops)
end

function T.inoremap(bind, to)
	return vim.api.nvim_set_keymap("i", bind, to, T.default_ops)
end

function T.vnoremap(bind, to)
	return vim.api.nvim_set_keymap("v", bind, to, T.default_ops)
end

function T.xnoremap(bind, to)
	return vim.api.nvim_set_keymap("x", bind, to, T.default_ops)
end

function T.map(mode, bind, to, opts)
	return vim.keymap.set(mode, bind, to, opts)
end

return T
