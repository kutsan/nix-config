--- Quotes text as a Nix string literal.
---@param text string
---@return string
local function nix_string(text)
	local escaped = text:gsub('\\', '\\\\'):gsub('"', '\\"'):gsub('%${', '\\${')

	return '"' .. escaped .. '"'
end

--- Builds an expression for the options of the first configuration in a flake
--- output, or an empty set when the flake has no such output.
---@param flake string
---@param output string
---@param suffix string
---@return string
local function first_configuration_options(flake, output, suffix)
	return string.format(
		'let configurations = %s.%s or { }; in if configurations == { } then { } else (builtins.head (builtins.attrValues configurations)).options%s',
		flake,
		output,
		suffix
	)
end

--- Completes packages and options from the flake at the project root.
---@param root string
---@return table
local function flake_settings(root)
	local flake = string.format('(builtins.getFlake %s)', nix_string(root))

	return {
		nixpkgs = {
			expr = string.format(
				'let flake = %s; in if flake.inputs ? nixpkgs then import flake.inputs.nixpkgs { } else { }',
				flake
			),
		},
		options = {
			['nix-darwin'] = {
				expr = first_configuration_options(flake, 'darwinConfigurations', ''),
			},
			['home-manager'] = {
				expr = first_configuration_options(
					flake,
					'darwinConfigurations',
					'.home-manager.users.type.getSubOptions [ ]'
				),
			},
			nixos = {
				expr = first_configuration_options(flake, 'nixosConfigurations', ''),
			},
		},
	}
end

---@type vim.lsp.Config
local LspConfig = {
	settings = {
		nixd = vim.empty_dict(),
	},
	before_init = function(_, config)
		local root = config.root_dir

		if not root or not vim.uv.fs_stat(root .. '/flake.nix') then
			return
		end

		config.settings = vim.tbl_deep_extend(
			'force',
			config.settings or {},
			{ nixd = flake_settings(root) }
		)
	end,
}

return LspConfig
