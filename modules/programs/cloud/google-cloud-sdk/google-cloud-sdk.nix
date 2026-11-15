let
  sharedModule =
    { pkgs, ... }:
    {
      environment.systemPackages = with pkgs; [
        google-cloud-sdk
      ];
    };
in
{
  flake.modules.nixos.google-cloud-sdk = sharedModule;
  flake.modules.darwin.google-cloud-sdk = sharedModule;
}
