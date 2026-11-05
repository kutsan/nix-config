{ inputs, ... }:
{
  imports = [
    inputs.flake-parts.flakeModules.modules
    inputs.nix-darwin.flakeModules.default
  ];

  systems = [
    "aarch64-darwin"
    "aarch64-linux"
    "x86_64-linux"
  ];
}
