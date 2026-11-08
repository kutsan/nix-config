{ inputs, ... }:
let
  configurationRevision = inputs.self.rev or inputs.self.dirtyRev or null;

  # Unfree packages are allowed by name only, all of them listed here.
  unfreePackages =
    { lib, ... }:
    {
      nixpkgs.config.allowUnfreePredicate =
        pkg:
        builtins.elem (lib.getName pkg) [
          "copilot-language-server"
        ];
    };
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
      ])
      ++ [ unfreePackages ];

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
      ])
      ++ [ unfreePackages ];

    system.configurationRevision = configurationRevision;
  };

  flake.modules.homeManager.system-default = {
    imports =
      with inputs.self.modules.homeManager;
      [
        sops-nix
      ]
      ++ (with inputs.self.modules.generic; [
        system-constants
      ]);

    home.stateVersion = "26.11";

    xdg.enable = true;
  };
}
