{ inputs, ... }:
let
  configurationRevision = inputs.self.rev or inputs.self.dirtyRev or null;
in
{
  flake.modules.nixos.system-default = {
    imports =
      with inputs.self.modules.nixos;
      [
        home-manager
      ]
      ++ (with inputs.self.modules.generic; [
        pkgs-by-name
        system-constants
      ]);

    system.configurationRevision = configurationRevision;

    nix.settings.experimental-features = [
      "nix-command"
      "flakes"
    ];
  };

  flake.modules.darwin.system-default = {
    imports =
      with inputs.self.modules.darwin;
      [
        determinate
        home-manager
        homebrew
      ]
      ++ (with inputs.self.modules.generic; [
        pkgs-by-name
        system-constants
      ]);

    system.configurationRevision = configurationRevision;
  };

  flake.modules.homeManager.system-default = {
    imports = [ inputs.self.modules.generic.system-constants ];

    home.stateVersion = "26.11";

    xdg.enable = true;
  };
}
