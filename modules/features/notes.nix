let
  packages =
    { pkgs, ... }:
    {
      environment.systemPackages = with pkgs; [
        zk
      ];
    };
in
{
  flake.modules.nixos.base = packages;
  flake.modules.darwin.base = packages;
}
