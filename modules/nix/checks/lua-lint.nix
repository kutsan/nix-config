{ inputs, ... }:
{
  perSystem =
    { lib, pkgs, ... }:
    {
      checks.lua-lint = pkgs.runCommand "check-lua-lint" { } ''
        cd ${inputs.self}/modules/programs/editors/neovim/config
        ${lib.getExe pkgs.selene} .
        touch "$out"
      '';
    };
}
