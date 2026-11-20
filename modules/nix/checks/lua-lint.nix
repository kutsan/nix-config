{ inputs, ... }:
{
  perSystem =
    { pkgs, ... }:
    {
      checks.lua-lint = pkgs.runCommand "check-lua-lint" { nativeBuildInputs = [ pkgs.selene ]; } ''
        cd ${inputs.self}/modules/programs/editors/neovim/config
        selene .
        touch "$out"
      '';
    };
}
