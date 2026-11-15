let
  sharedModule =
    { pkgs, ... }:
    {
      environment.systemPackages = with pkgs; [
        devcontainer
      ];
    };
in
{
  flake.modules.nixos.devcontainer = sharedModule;
  flake.modules.darwin.devcontainer = sharedModule;
}
