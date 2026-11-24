{
  flake.modules.darwin.iina =
    { pkgs, ... }:
    {
      environment.systemPackages = [ pkgs.iina ];

      system.defaults.CustomUserPreferences."com.colliderli.iina".SUEnableAutomaticChecks = false;
    };
}
