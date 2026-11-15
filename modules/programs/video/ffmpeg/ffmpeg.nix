let
  sharedModule =
    { pkgs, ... }:
    {
      environment.systemPackages = with pkgs; [
        ffmpeg
      ];
    };
in
{
  flake.modules.nixos.ffmpeg = sharedModule;
  flake.modules.darwin.ffmpeg = sharedModule;
}
