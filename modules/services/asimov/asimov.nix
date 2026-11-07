{
  flake.modules.darwin.asimov =
    {
      config,
      lib,
      pkgs,
      ...
    }:
    let
      user = config.systemConstants.username;
      logPath = "/Users/${user}/Library/Logs/asimov.log";
    in
    {
      environment.systemPackages = [ pkgs.local.asimov ];

      launchd.user.agents.asimov = {
        command = "${lib.getExe pkgs.local.asimov} --quiet";
        serviceConfig = {
          StartInterval = 86400;
          StandardOutPath = logPath;
          StandardErrorPath = logPath;
        };
      };
    };
}
