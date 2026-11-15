let
  sharedModule =
    { pkgs, ... }:
    {
      environment.systemPackages = with pkgs; [
        nodejs_26
      ];
    };
in
{
  flake.modules.nixos.nodejs = sharedModule;
  flake.modules.darwin.nodejs = sharedModule;
}
