let
  sharedModule =
    { pkgs, ... }:
    {
      environment.systemPackages = with pkgs; [
        age
        gnupg
      ];
    };
in
{
  flake.modules.nixos.encryption = sharedModule;
  flake.modules.darwin.encryption = sharedModule;
}
