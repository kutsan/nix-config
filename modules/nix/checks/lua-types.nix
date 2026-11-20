{
  perSystem =
    { pkgs, mkSandboxCheck, ... }:
    {
      checks.lua-types = mkSandboxCheck "lua-types" {
        tools = [ pkgs.lua-language-server ];
        script = ''
          VIMRUNTIME=${pkgs.neovim-unwrapped}/share/nvim/runtime \
            lua-language-server --check modules/programs/editors/neovim/config
        '';
      };
    };
}
