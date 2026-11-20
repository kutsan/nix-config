{
  perSystem =
    { lib, pkgs, ... }:
    {
      formatters.toml = {
        command = lib.getExe pkgs.tombi;
        options = [
          "format"
          "--offline"
        ];
        includes = [ "*.toml" ];
      };
    };
}
