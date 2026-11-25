{
  flake.modules.darwin.sketchybar =
    {
      config,
      lib,
      pkgs,
      ...
    }:
    let
      configDirectory = lib.fileset.toSource {
        root = ./.;
        fileset = lib.fileset.difference ./. ./sketchybar.nix;
      };
    in
    {
      services.sketchybar = {
        enable = true;
        config = "${configDirectory}/sketchybarrc";
        extraPackages = [
          config.services.yabai.package
          pkgs.local.macos-next-calendar-event
        ];
      };
    };
}
