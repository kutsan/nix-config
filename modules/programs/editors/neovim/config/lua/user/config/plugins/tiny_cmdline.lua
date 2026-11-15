local tiny_cmdline = require('tiny-cmdline')

tiny_cmdline.setup({
	position = {
		x = '50%',
		y = '10%',
	},
	on_reposition = tiny_cmdline.adapters.blink,
})
