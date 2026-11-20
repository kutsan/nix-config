{ inputs, ... }:
{
  perSystem =
    { pkgs, ... }:
    {
      checks.lua-types =
        pkgs.runCommand "check-lua-types"
          {
            nativeBuildInputs = with pkgs; [
              lua-language-server
              writableTmpDirAsHomeHook
            ];
            env.VIMRUNTIME = "${pkgs.neovim-unwrapped}/share/nvim/runtime";
          }
          ''
            cd ${inputs.self}
            lua-language-server --check modules/programs/editors/neovim/config
            touch "$out"
          '';
    };
}
