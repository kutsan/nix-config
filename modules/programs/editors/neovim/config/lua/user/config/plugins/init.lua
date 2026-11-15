-- Disable unused built-in plugins.
vim.g.loaded_tar = true
vim.g.loaded_zip = true
vim.g.loaded_gzip = true
vim.g.loaded_tarPlugin = true
vim.g.loaded_zipPlugin = true
vim.g.loaded_netrw = true
vim.g.loaded_netrwPlugin = true
vim.g.loaded_tutor_mode_plugin = true
vim.g.loaded_matchit = true
vim.g.loaded_remote_plugins = true

local plugins = {
	-- Completion & Tooling
	{ 'blink_cmp', requires = { 'lazydev' } },
	{ 'lazydev' },
	{ 'schema_store' },
	{ 'conform' },
	{ 'ts_error_translator' },

	-- Git
	{ 'gitsigns' },
	{ 'codediff' },

	-- Navigation & Buffers
	{ 'bufferline', requires = { 'mini_icons' } },
	{ 'flash' },
	{ 'windovigation' },
	{ 'scope' },

	-- Search & Replace
	{ 'grug_far' },

	-- Editing & Text Objects
	{ 'mini_surround' },
	{ 'mini_pairs' },

	-- Visual
	{ 'mini_icons' },
	{ 'highlight_colors' },
	{ 'color_converter' },
	{ 'mini_indentscope' },
	{ 'render_markdown' },
	{ 'snacks' },
	{ 'tiny_cmdline', requires = { 'blink_cmp' } },

	-- Utilities
	{ 'early_retirement' },
	{ 'qmk' },
}

local plugin_loader = require('user.api.plugins.loader')

-- Load plugins in order, respecting dependencies.
plugin_loader.load(plugins, function(plugin_file_name)
	local plugin_module =
		string.format('user.config.plugins.%s', plugin_file_name)

	require(plugin_module)
end)
