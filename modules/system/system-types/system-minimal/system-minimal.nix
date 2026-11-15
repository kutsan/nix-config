{ inputs, ... }:
let
  sharedModule = {
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
    home.language.base = "en_US.UTF-8";

    xdg.enable = true;
    xdg.localBinInPath = true;
  };
}
