{ inputs, ... }:
{
  flake.modules.darwin.qmk = {
    home-manager.sharedModules = [ inputs.self.modules.homeManager.qmk ];
  };

  flake.modules.homeManager.qmk =
    { config, ... }:
    {
      xdg.configFile = {
        "qmk/qmk.ini".text = ''
          [user]
          qmk_home = ${config.xdg.dataHome}/qmk-firmware
          overlay_dir = ${config.xdg.configHome}/qmk-userspace
          keyboard = keychron/v4/ansi
          keymap = main
        '';

        qmk-userspace = {
          source = ./userspace;
          recursive = true;
        };
      };
    };
}
