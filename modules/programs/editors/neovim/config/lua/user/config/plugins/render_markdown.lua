local render_markdown = require('render-markdown')

local opts = {
	latex = {
		enabled = false,
	},
}

render_markdown.setup(opts)
