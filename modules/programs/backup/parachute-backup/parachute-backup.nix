{
  flake.modules.darwin.parachute-backup = {
    launchd.user.agents.parachute-backup.serviceConfig = {
      ProgramArguments = [
        "/usr/bin/open"
        "--background"
        "--hide"
        "-b"
        "net.ericmann.parachute"
      ];
      RunAtLoad = true;
    };
  };
}
