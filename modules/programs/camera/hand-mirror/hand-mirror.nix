{
  flake.modules.darwin.hand-mirror = {
    launchd.user.agents.hand-mirror.serviceConfig = {
      ProgramArguments = [
        "/usr/bin/open"
        "--background"
        "--hide"
        "-b"
        "net.rafaelconde.Hand-Mirror"
      ];
      RunAtLoad = true;
    };
  };
}
