{
  flake.modules.darwin.sketchybar =
    { config, lib, ... }:
    let
      configDirectory = lib.fileset.toSource {
        root = ./.;
        fileset = lib.fileset.unions [
          ./sketchybarrc
          ./options
          ./sections
          ./styles
        ];
      };
    in
    {
      services.sketchybar.enable = true;

      launchd.user.agents.sketchybar.serviceConfig.ProgramArguments = lib.mkForce [
        "${config.services.sketchybar.package}/bin/sketchybar"
        "--config"
        "${configDirectory}/sketchybarrc"
      ];
    };
}
