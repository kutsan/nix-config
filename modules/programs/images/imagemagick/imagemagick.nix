let
  sharedModule =
    { pkgs, ... }:
    {
      environment.systemPackages = with pkgs; [
        imagemagick
      ];
    };
in
{
  flake.modules.nixos.imagemagick = sharedModule;
  flake.modules.darwin.imagemagick = sharedModule;
}
