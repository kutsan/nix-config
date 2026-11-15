let
  sharedModule =
    { pkgs, ... }:
    {
      environment.systemPackages = with pkgs; [
        dive
      ];
    };
in
{
  flake.modules.nixos.dive = sharedModule;
  flake.modules.darwin.dive = sharedModule;
}
