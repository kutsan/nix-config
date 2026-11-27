{ inputs, ... }:
{
  flake.modules.darwin.zed = {
    homebrew.casks = [
      "zed"
    ];

    home-manager.sharedModules = [
      inputs.self.modules.homeManager.zed
      { home.sessionVariables.GUI_EDITOR = "zed"; }
    ];
  };

  flake.modules.nixos.zed =
    { pkgs, ... }:
    {
      environment.systemPackages = [ pkgs.zed-editor ];

      home-manager.sharedModules = [
        inputs.self.modules.homeManager.zed
        { home.sessionVariables.GUI_EDITOR = "zeditor"; }
      ];
    };

  flake.modules.homeManager.zed = {
    programs.zed-editor = {
      enable = true;
      package = null;

      mutableUserSettings = false;
      mutableUserKeymaps = false;

      themes.poisonbloom = inputs.poisonbloom.lib.themes.zed;
    };
  };
}
