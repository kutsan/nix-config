{ inputs, ... }:
let
  sharedModule =
    { lib, ... }:
    {
      nixpkgs.config.allowUnfreePredicate =
        pkg:
        builtins.elem (lib.getName pkg) [
          "copilot-language-server"
        ];

      system.configurationRevision = inputs.self.rev or inputs.self.dirtyRev or null;
    };
in
{
  flake.modules.nixos.system-minimal = {
    imports = [ sharedModule ];

    nix.settings.experimental-features = [
      "nix-command"
      "flakes"
    ];
  };

  flake.modules.darwin.system-minimal = sharedModule;

  flake.modules.homeManager.system-minimal = {
    home.stateVersion = "26.11";

    xdg.enable = true;
  };
}
