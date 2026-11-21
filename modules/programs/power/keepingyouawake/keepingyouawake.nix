{
  flake.modules.darwin.keepingyouawake = {
    homebrew.casks = [
      "keepingyouawake"
    ];

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
  };
}
