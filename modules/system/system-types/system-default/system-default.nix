{ inputs, ... }:
let
  configurationRevision = inputs.self.rev or inputs.self.dirtyRev or null;
in
{
  flake.modules.nixos.system-default = {
    imports = with inputs.self.modules.generic; [
      pkgs-by-name
      system-constants
    ];

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
        homebrew
      ]
      ++ (with inputs.self.modules.generic; [
        pkgs-by-name
        system-constants
      ]);

    system.configurationRevision = configurationRevision;
  };
}
