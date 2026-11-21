{
  flake.modules.darwin.apple-mail = {
    launchd.user.agents.apple-mail.serviceConfig = {
      ProgramArguments = [
        "/usr/bin/open"
        "--background"
        "--hide"
        "-b"
        "com.apple.mail"
      ];
      RunAtLoad = true;
    };
  };
}
