{
  flake.modules.darwin.goodlinks = {
    home-manager.sharedModules = [
      {
        programs.mcp.servers.goodlinks = {
          command = "/Applications/GoodLinks.app/Contents/MacOS/CLI/goodlinks";
          args = [ "mcp-server" ];
        };
      }
    ];
  };
}
