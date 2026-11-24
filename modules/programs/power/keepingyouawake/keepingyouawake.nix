{
  flake.modules.darwin.keepingyouawake =
    { pkgs, ... }:
    {
      environment.systemPackages = [ pkgs.keepingyouawake ];

      launchd.user.agents.keepingyouawake.serviceConfig = {
        ProgramArguments = [
          "/usr/bin/open"
          "--background"
          "--hide"
          "-b"
          "info.marcel-dierkes.KeepingYouAwake"
        ];
        RunAtLoad = true;
      };

      home-manager.sharedModules = [
        {
          manualSetup.keepingyouawake = [
            "In **KeepingYouAwake > Settings**, turn off automatic update checks."
          ];
        }
      ];
    };
}
