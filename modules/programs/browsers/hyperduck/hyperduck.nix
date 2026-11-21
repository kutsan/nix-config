{
  flake.modules.darwin.hyperduck = {
    launchd.user.agents.hyperduck.serviceConfig = {
      ProgramArguments = [
        "/usr/bin/open"
        "--background"
        "--hide"
        "-b"
        "com.sindresorhus.Hyperduck"
      ];
      RunAtLoad = true;
    };
  };
}
