{
  flake.modules.darwin.tasks = {
    home-manager.sharedModules = [
      {
        programs.mcp.servers.tasks = {
          command = "/Applications/Tasks.app/Contents/Resources/tasks";
          args = [ "mcp" ];
        };
      }
    ];
  };
}
