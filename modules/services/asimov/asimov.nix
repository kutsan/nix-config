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
      logDirectory = "/Users/${user}/Library/Logs/asimov";
      logPath = "${logDirectory}/asimov.log";
    in
    {
      environment.systemPackages = [ pkgs.local.asimov ];

      system.activationScripts.extraActivation.text = ''
        install -d -m 755 -o ${user} -g staff ${lib.escapeShellArg logDirectory}
      '';

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
