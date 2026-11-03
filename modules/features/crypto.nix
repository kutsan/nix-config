let
  packages =
    { pkgs, ... }:
    {
      environment.systemPackages = with pkgs; [
        age
        gnupg
      ];
    };
in
{
  flake.modules.nixos.base = packages;
  flake.modules.darwin.base = packages;
}
