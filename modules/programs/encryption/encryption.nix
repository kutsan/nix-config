let
  sharedModule =
    { pkgs, ... }:
    {
      environment.systemPackages = with pkgs; [
        age
      ];
    };
in
{
  flake.modules.nixos.encryption = sharedModule;
  flake.modules.darwin.encryption = sharedModule;
}
