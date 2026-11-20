{ inputs, ... }:
{
  perSystem =
    { lib, pkgs, ... }:
    {
      checks.lua-types = pkgs.runCommand "check-lua-types" { } ''
        cd ${inputs.self}
        VIMRUNTIME=${pkgs.neovim-unwrapped}/share/nvim/runtime \
          ${lib.getExe pkgs.lua-language-server} --check modules/programs/editors/neovim/config
        touch "$out"
      '';
    };
}
