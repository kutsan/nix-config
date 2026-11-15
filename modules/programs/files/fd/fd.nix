let
  sharedModule =
    { pkgs, ... }:
    {
      environment.systemPackages = with pkgs; [
        fd
      ];
    };
in
{
  flake.modules.nixos.fd = sharedModule;
  flake.modules.darwin.fd = sharedModule;
}
