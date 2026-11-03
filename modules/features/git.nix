let
  packages =
    { pkgs, ... }:
    {
      environment.systemPackages = with pkgs; [
        delta
        gh
        git
        git-standup
        lazygit
      ];
    };
in
{
  flake.modules.nixos.base = packages;
  flake.modules.darwin.base = packages;
}
