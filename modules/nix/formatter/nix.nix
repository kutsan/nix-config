{
  perSystem =
    { lib, pkgs, ... }:
    {
      formatters.nix = {
        command = lib.getExe pkgs.nixfmt;
        includes = [ "*.nix" ];
      };
    };
}
