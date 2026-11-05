let
  sharedModule =
    { pkgs, ... }:
    {
      environment.systemPackages = with pkgs; [
        google-cloud-sdk
        google-cloud-sql-proxy
      ];
    };
in
{
  flake.modules.nixos.cloud = sharedModule;
  flake.modules.darwin.cloud = sharedModule;
}
