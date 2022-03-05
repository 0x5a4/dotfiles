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
	return vim.api.nvim_set_keymap(mode, bind, to, opts)
end

-- Auto Commands
local function acmd(this, event, spec)
	local is_table = type(spec) == 'table'
	local pattern = is_table and spec[1] or '*'
	local action = is_table and spec[2] or spec
	if type(action) == 'function' then
		action = this.set(action)
	end
	local e = type(event) == 'table' and table.concat(event, ',') or event
	vim.api.nvim_command('autocmd '..e..' '..pattern..' '..action)
end

local S = {
	__au = {},
}

T.autocmd = setmetatable({}, {
	__index = S,
	__newindex = acmd,
	__call = acmd
})

function S.exec(id)
	S.__au[id]()
end

function S.set(fn)
    local id = string.format('%p', fn)
    S.__au[id] = fn
    return string.format('lua require("au").exec("%s")', id)
end

function S.group(grp, cmds)
	local cmd = vim.cmd
    cmd('augroup ' .. grp)
    cmd('autocmd!')
    if type(cmds) == 'function' then
        cmds(T.autocmd)
    else
        for _, au in ipairs(cmds) do
            acmd(S, au[1], { au[2], au[3] })
        end
    end
    cmd('augroup END')
end

return T
