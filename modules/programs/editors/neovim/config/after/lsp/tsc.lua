---@type vim.lsp.Config
local LspConfig = {
	settings = {
		['js/ts'] = {
			inlayHints = {
				parameterNames = {
					enabled = 'all',
					suppressWhenArgumentMatchesName = false,
				},
				variableTypes = {
					suppressWhenTypeMatchesName = false,
				},
			},
		},
	},
}

return LspConfig
