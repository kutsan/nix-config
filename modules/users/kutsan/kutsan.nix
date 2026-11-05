{ inputs, ... }:
let
  username = "kutsan";

  sharedModule = {
    home-manager.users.${username}.imports = [ inputs.self.modules.homeManager.${username} ];
  };
in
{
  flake.modules.nixos.${username} = {
    imports = [ sharedModule ];

    users.users.${username} = {
      isNormalUser = true;
      extraGroups = [ "wheel" ];
    };
  };

  flake.modules.darwin.${username} = {
    imports = [ sharedModule ];

    users.users.${username}.home = "/Users/${username}";

    system.primaryUser = username;
  };

  flake.modules.homeManager.${username} = {
    imports = with inputs.self.modules.homeManager; [
      system-default

      lazydocker
      lazygit
      less
    ];
  };
}
