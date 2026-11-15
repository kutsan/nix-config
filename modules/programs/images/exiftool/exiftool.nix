let
  sharedModule =
    { pkgs, ... }:
    {
      environment.systemPackages = with pkgs; [
        exiftool
      ];
    };
in
{
  flake.modules.nixos.exiftool = sharedModule;
  flake.modules.darwin.exiftool = sharedModule;
}
