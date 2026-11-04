{ inputs, ... }:
{
  flake.modules.darwin.base =
    { config, ... }:
    {
      imports = [ inputs.nix-homebrew.darwinModules.nix-homebrew ];

      nix-homebrew = {
        enable = true;
        user = config.system.primaryUser;
        autoMigrate = true;
        mutableTaps = false;
        taps = {
          "docker/homebrew-tap" = inputs.homebrew-docker;
          "jackielii/homebrew-tap" = inputs.homebrew-jackielii;
        };
        extraEnv.HOMEBREW_NO_ANALYTICS = "1";
      };

      homebrew = {
        enable = true;
        onActivation.cleanup = "zap";
        taps = builtins.attrNames config.nix-homebrew.taps;
      };
    };
}
