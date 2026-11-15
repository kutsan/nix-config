local highlight_colors = require('nvim-highlight-colors')

local opts = {
	render = 'virtual',
	virtual_symbol = '',
	names = false,
	rgb_fn = true,
	hsl_fn = true,
}

highlight_colors.setup(opts)
