{ inputs, ... }:
{
  flake.modules.darwin.skhd = {
    homebrew.casks = [
      "jackielii/tap/skhd-zig"
    ];

    home-manager.sharedModules = [ inputs.self.modules.homeManager.skhd ];
  };

  flake.modules.homeManager.skhd =
    { lib, osConfig, ... }:
    {
      xdg.configFile.skhd = {
        source = lib.fileset.toSource {
          root = ./.;
          fileset = lib.fileset.unions [
            ./skhdrc
            ./config
            ./scripts
          ];
        };
        onChange = ''
          if /usr/bin/pgrep -qx skhd; then
            ${osConfig.homebrew.prefix}/bin/skhd --restart-service
          fi
        '';
      };
    };
}
