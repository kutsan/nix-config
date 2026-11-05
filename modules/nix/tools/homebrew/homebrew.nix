{ inputs, ... }:
{
  flake.modules.darwin.homebrew =
    { config, ... }:
    {
      imports = [ inputs.nix-homebrew.darwinModules.nix-homebrew ];

      nix-homebrew = {
        enable = true;
        user = config.systemConstants.username;
        autoMigrate = true;
        mutableTaps = false;
        taps = {
          "docker/homebrew-tap" = inputs.homebrew-docker;
          "jackielii/homebrew-tap" = inputs.homebrew-jackielii;
        };
        extraEnv = {
          HOMEBREW_CLEANUP_MAX_AGE_DAYS = "7";
          HOMEBREW_CLEANUP_PERIODIC_FULL_DAYS = "7";
          HOMEBREW_DISPLAY_INSTALL_TIMES = "1";
          HOMEBREW_NO_ANALYTICS = "1";
          HOMEBREW_NO_EMOJI = "1";
          HOMEBREW_NO_ENV_HINTS = "1";
        };
      };

      homebrew = {
        enable = true;
        onActivation.cleanup = "zap";
        taps = builtins.attrNames config.nix-homebrew.taps;
      };
    };
}
