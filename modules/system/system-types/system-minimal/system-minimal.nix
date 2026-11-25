{ inputs, ... }:
let
  selectStaticChecks =
    system:
    builtins.attrValues (
      removeAttrs inputs.self.checks.${system} [
        "flake-darwin-evaluation"
        "flake-nixos-evaluation"
      ]
    );

  sharedModule = {
    system.configurationRevision = inputs.self.rev or inputs.self.dirtyRev or null;
  };
in
{
  flake.modules.nixos.system-minimal =
    { pkgs, ... }:
    {
      imports = [ sharedModule ];

      system.checks = selectStaticChecks pkgs.stdenv.hostPlatform.system;

      nix.settings.experimental-features = [
        "nix-command"
        "flakes"
      ];
    };

  flake.modules.darwin.system-minimal =
    { pkgs, ... }:
    {
      imports = [
        sharedModule
        inputs.self.modules.darwin.locale
      ];

      system.keyboard.enableKeyMapping = true;

      system.systemBuilderArgs.passedChecks = builtins.concatStringsSep " " (
        selectStaticChecks pkgs.stdenv.hostPlatform.system
      );
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
