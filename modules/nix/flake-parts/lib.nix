{ inputs, lib, ... }:
{
  options.flake.lib = lib.mkOption {
    type = lib.types.lazyAttrsOf lib.types.raw;
    default = { };
  };

  config.flake.lib = {
    mkDarwin =
      { system, host }:
      {
        ${host} = inputs.nix-darwin.lib.darwinSystem {
          modules = [
            inputs.self.modules.darwin.${host}
            { nixpkgs.hostPlatform = lib.mkDefault system; }
          ];
        };
      };

    mkNixos =
      { system, host }:
      {
        ${host} = inputs.nixpkgs.lib.nixosSystem {
          modules = [
            inputs.self.modules.nixos.${host}
            {
              nixpkgs.hostPlatform = lib.mkDefault system;
              networking.hostName = lib.mkDefault host;
            }
          ];
        };
      };
  };
}
