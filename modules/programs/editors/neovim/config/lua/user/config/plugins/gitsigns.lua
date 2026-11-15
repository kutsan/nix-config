local gitsigns = require('gitsigns')

local opts = {
	on_attach = function(bufnr)
		vim.keymap.set(
			'n',
			'<Space>gb',
			gitsigns.blame,
			{ buffer = bufnr, silent = true, desc = 'Git blame' }
		)
	end,
}

gitsigns.setup(opts)
