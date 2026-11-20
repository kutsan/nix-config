{
  perSystem =
    { lib, pkgs, ... }:
    {
      formatters.justfile = {
        command = lib.getExe pkgs.just;
        options = [
          "--fmt"
          "--justfile"
        ];
        includes = [ "justfile" ];
      };
    };
}
