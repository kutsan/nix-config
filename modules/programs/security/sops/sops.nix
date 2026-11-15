let
  sharedModule =
    { pkgs, ... }:
    {
      environment.systemPackages = with pkgs; [
        sops
      ];
    };
in
{
  flake.modules.nixos.sops = sharedModule;
  flake.modules.darwin.sops = sharedModule;
}
