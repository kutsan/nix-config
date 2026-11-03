let
  packages =
    { pkgs, ... }:
    {
      environment.systemPackages = with pkgs; [
        nmap
        trippy
      ];
    };
in
{
  flake.modules.nixos.base = packages;
  flake.modules.darwin.base = packages;
}
