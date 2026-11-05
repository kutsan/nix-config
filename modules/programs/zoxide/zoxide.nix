{
  flake.modules.homeManager.zoxide =
    { config, ... }:
    {
      programs.zoxide.enable = true;

      home.sessionVariables = {
        _ZO_DATA_DIR = "${config.xdg.dataHome}/zoxide";
        _ZO_EXCLUDE_DIRS = "**/node_modules";
      };
    };
}
