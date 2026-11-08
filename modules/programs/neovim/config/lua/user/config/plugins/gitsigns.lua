local gitsigns = require('gitsigns')

local opts = {
	on_attach = function()
		vim.keymap.set(
			'n',
			'<Space>gb',
			gitsigns.blame,
			{ silent = true, desc = 'Git blame' }
		)
	end,
}

gitsigns.setup(opts)
