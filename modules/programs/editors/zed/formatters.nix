{
  flake.modules.homeManager.zed =
    { lib, pkgs, ... }:
    {
      programs.zed-editor.userSettings.languages = {
        Lua.formatter.external = {
          command = lib.getExe pkgs.stylua;
          arguments = [
            "--search-parent-directories"
            "--respect-ignores"
            "--stdin-filepath"
            "{buffer_path}"
            "-"
          ];
        };
        Nix.formatter.external = {
          command = lib.getExe pkgs.nixfmt;
          arguments = [
            "--filename={buffer_path}"
            "-"
          ];
        };
        "Shell Script".formatter.external = {
          command = lib.getExe pkgs.shfmt;
          arguments = [
            "-filename"
            "{buffer_path}"
          ];
        };
        Typst.formatter.external.command = lib.getExe pkgs.typstyle;
      };
    };
}
