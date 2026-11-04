let
  packages =
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
  flake.modules.nixos.base = packages;

  flake.modules.darwin.base = {
    imports = [ packages ];

    homebrew.casks = [
      "audacity"
      "handbrake-app"
      "iina"
      "obs"
    ];
  };
}
