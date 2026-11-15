{
  flake.modules.darwin.sketchybar =
    { lib, ... }:
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
      };
    };
}
