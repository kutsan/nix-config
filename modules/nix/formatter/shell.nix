{
  perSystem =
    { lib, pkgs, ... }:
    {
      formatters.shell = {
        command = lib.getExe pkgs.shfmt;
        options = [ "--write" ];
        includes = [
          "*.sh"
          "*.zsh"
        ];
      };
    };
}
