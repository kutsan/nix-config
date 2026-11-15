let
  sharedModule =
    { pkgs, ... }:
    {
      environment.systemPackages = with pkgs; [
        google-cloud-sql-proxy
      ];
    };
in
{
  flake.modules.nixos.google-cloud-sql-proxy = sharedModule;
  flake.modules.darwin.google-cloud-sql-proxy = sharedModule;
}
