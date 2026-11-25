{ inputs, ... }:
{
  flake.modules.darwin.asimov = {
    home-manager.sharedModules = [ inputs.self.modules.homeManager.asimov ];
  };

  flake.modules.homeManager.asimov =
    {
      config,
      lib,
      pkgs,
      ...
    }:
    let
      logPath = "${config.home.homeDirectory}/Library/Logs/asimov.log";
    in
    {
      home.packages = [ pkgs.local.asimov ];

      launchd.agents.asimov = {
        enable = true;

        config = {
          ProgramArguments = [
            (lib.getExe pkgs.local.asimov)
            "--quiet"
          ];
          StartInterval = 86400;
          StandardOutPath = logPath;
          StandardErrorPath = logPath;
        };
      };
    };
}
