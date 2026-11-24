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

  flake.modules.darwin.system-minimal = {
    imports = [
      sharedModule
      inputs.self.modules.darwin.locale
    ];
  };

  flake.modules.homeManager.system-minimal = {
    imports = with inputs.self.modules.homeManager; [
      locale
      manual-setup
    ];

    home.stateVersion = "26.11";

    xdg.enable = true;
    xdg.localBinInPath = true;
  };
}
