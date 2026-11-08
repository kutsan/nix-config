local mini_indentscope = require('mini.indentscope')

local opts = {
	options = {
		indent_at_cursor = false,
	},
	draw = {
		predicate = function()
			return false
		end,
	},
}

mini_indentscope.setup(opts)
