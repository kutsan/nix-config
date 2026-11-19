{ inputs, ... }:
{
  flake.modules.nixos.system-default = {
    imports =
      with inputs.self.modules.nixos;
      [
        system-minimal
        home-manager
      ]
      ++ (with inputs.self.modules.generic; [
        pkgs-by-name
        system-constants
      ]);

    home-manager.sharedModules = [ inputs.self.modules.homeManager.system-default ];
  };

  flake.modules.darwin.system-default = {
    imports =
      with inputs.self.modules.darwin;
      [
        system-minimal
        determinate
        home-manager
        homebrew
      ]
      ++ (with inputs.self.modules.generic; [
        pkgs-by-name
        system-constants
      ]);

    home-manager.sharedModules = [ inputs.self.modules.homeManager.system-default ];
  };

  flake.modules.homeManager.system-default = {
    imports = with inputs.self.modules.homeManager; [
      system-minimal
      sops-nix
      identity
    ];
  };
}
