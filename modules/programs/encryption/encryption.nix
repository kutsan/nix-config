let
  sharedModule =
    { pkgs, ... }:
    {
      environment.systemPackages = with pkgs; [
        age
        sops
      ];
    };
in
{
  flake.modules.nixos.encryption = sharedModule;
  flake.modules.darwin.encryption = sharedModule;
}
