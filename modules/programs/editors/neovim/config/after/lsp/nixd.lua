local completion_sources_template = [[
let
  projectFlake = builtins.getFlake %q;

  firstConfiguration =
    outputName:
    let
      configurations = projectFlake.${outputName} or { };
    in
    builtins.head (builtins.attrValues configurations ++ [ { } ]);

  darwinConfiguration = firstConfiguration "darwinConfigurations";
  nixosConfiguration = firstConfiguration "nixosConfigurations";
  homeConfiguration = firstConfiguration "homeConfigurations";

  homeManagerUsersOption =
    darwinConfiguration.options.home-manager.users
      or nixosConfiguration.options.home-manager.users
      or null;

  homeManagerModuleOptions =
    if homeManagerUsersOption == null then
      { }
    else
      homeManagerUsersOption.type.getSubOptions [ ];
in
{
  nixpkgs = import (projectFlake.inputs.nixpkgs or <nixpkgs>) { };
  darwinOptions = darwinConfiguration.options or { };
  nixosOptions = nixosConfiguration.options or { };
  homeManagerOptions = homeConfiguration.options or homeManagerModuleOptions;
}
]]

---@param directory string
---@return boolean
local function has_flake(directory)
	return vim.uv.fs_stat(vim.fs.joinpath(directory, 'flake.nix')) ~= nil
end

---@param sources string
---@param attribute_name string
---@return { expr: string }
local function completion_source(sources, attribute_name)
	return { expr = string.format('(%s).%s', sources, attribute_name) }
end

---@type vim.lsp.Config
local LspConfig = {
	settings = {
		nixd = vim.empty_dict(),
	},

	before_init = function(_, config)
		local project_root = config.root_dir

		if not project_root or not has_flake(project_root) then
			return
		end

		local sources = completion_sources_template:format(project_root)

		config.settings.nixd = {
			nixpkgs = completion_source(sources, 'nixpkgs'),

			options = {
				nixos = completion_source(sources, 'nixosOptions'),
				['nix-darwin'] = completion_source(sources, 'darwinOptions'),
				['home-manager'] = completion_source(sources, 'homeManagerOptions'),
			},
		}
	end,
}

return LspConfig
