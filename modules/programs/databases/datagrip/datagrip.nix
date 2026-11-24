{
  flake.modules.darwin.datagrip =
    { pkgs, ... }:
    {
      environment.systemPackages = [ pkgs.jetbrains.datagrip ];

      nixpkgs.config.allowUnfreePackages = [ "datagrip" ];

      home-manager.sharedModules = [
        {
          manualSetup.datagrip = [
            "In **DataGrip > Settings > Appearance & Behavior > System Settings > Updates**, turn off **Check IDE updates**."
          ];
        }
      ];
    };
}
