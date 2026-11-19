{ inputs, ... }:
let
  sharedModule = {
    home-manager.sharedModules = [ inputs.self.modules.homeManager.work ];
  };
in
{
  flake.modules.nixos.work = sharedModule;

  flake.modules.darwin.work = sharedModule;

  flake.modules.homeManager.work = {
    programs.git.includes = [
      {
        condition = "gitdir:~/Documents/Work/";
        contents.user.email = "work@example.com";
      }
    ];
  };
}
