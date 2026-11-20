{
  perSystem =
    { pkgs, mkSandboxCheck, ... }:
    {
      checks.lua-lint = mkSandboxCheck "lua-lint" {
        tools = [ pkgs.selene ];
        script = ''
          cd modules/programs/editors/neovim/config
          selene .
        '';
      };
    };
}
