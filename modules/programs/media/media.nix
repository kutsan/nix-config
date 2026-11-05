let
  sharedModule =
    { pkgs, ... }:
    {
      environment.systemPackages = with pkgs; [
        exiftool
        ffmpeg
        imagemagick
      ];
    };
in
{
  flake.modules.nixos.media = sharedModule;

  flake.modules.darwin.media = {
    imports = [ sharedModule ];

    homebrew.casks = [
      "audacity"
      "handbrake-app"
      "iina"
      "obs"
    ];
  };
}
