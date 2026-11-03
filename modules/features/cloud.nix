let
  packages =
    { pkgs, ... }:
    {
      environment.systemPackages = with pkgs; [
        google-cloud-sdk
        google-cloud-sql-proxy
      ];
    };
in
{
  flake.modules.nixos.base = packages;
  flake.modules.darwin.base = packages;
}
