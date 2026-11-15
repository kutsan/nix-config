let
  sharedModule =
    { pkgs, ... }:
    {
      environment.systemPackages = with pkgs; [
        tree
      ];
    };
in
{
  flake.modules.nixos.tree = sharedModule;
  flake.modules.darwin.tree = sharedModule;
}
