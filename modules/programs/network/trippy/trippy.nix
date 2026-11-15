let
  sharedModule =
    { pkgs, ... }:
    {
      environment.systemPackages = with pkgs; [
        trippy
      ];
    };
in
{
  flake.modules.nixos.trippy = sharedModule;
  flake.modules.darwin.trippy = sharedModule;
}
