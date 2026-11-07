{ inputs, ... }:
{
  flake.modules.darwin.qmk = {
    home-manager.sharedModules = [ inputs.self.modules.homeManager.qmk ];
  };

  flake.modules.homeManager.qmk =
    {
      config,
      lib,
      pkgs,
      ...
    }:
    let
      qmkHome = "${config.xdg.dataHome}/qmk-firmware";
    in
    {
      home.sessionVariables.QMK_HOME = qmkHome;

      xdg.configFile = {
        "qmk/qmk.ini".text = ''
          [user]
          qmk_home = ${qmkHome}
          overlay_dir = ${config.xdg.configHome}/qmk-userspace
          keyboard = keychron/v4/ansi
          keymap = main
        '';

        qmk-userspace = {
          source = ./userspace;
          recursive = true;
        };
      };

      home.file."Library/Application Support/qmk" = lib.mkIf pkgs.stdenv.hostPlatform.isDarwin {
        source = config.lib.file.mkOutOfStoreSymlink "${config.xdg.configHome}/qmk";
      };
    };
}
