local function set_shada_file()
	---@type string
	local directory = vim.fs.root(0, '.git')
		or vim.env.GIT_WORK_TREE
		or assert(vim.uv.cwd())

	vim.o.shadafile = vim.fs.joinpath(
		vim.fn.stdpath('state'),
		'shada',
		vim.fs.basename(directory) .. '.shada'
	)
end

return { set_shada_file = set_shada_file }
