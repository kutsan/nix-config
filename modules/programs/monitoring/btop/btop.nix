let
  sharedModule =
    { pkgs, ... }:
    {
      environment.systemPackages = with pkgs; [
        btop
      ];
    };
in
{
  flake.modules.nixos.btop = sharedModule;
  flake.modules.darwin.btop = sharedModule;
}
