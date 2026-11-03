let
  packages =
    { pkgs, ... }:
    {
      environment.systemPackages = with pkgs; [
        bat
        btop
        fd
        fx
        fzf
        jq
        ripgrep
        tokei
        tree
        yazi
        zoxide
      ];
    };
in
{
  flake.modules.nixos.base = packages;
  flake.modules.darwin.base = packages;
}
