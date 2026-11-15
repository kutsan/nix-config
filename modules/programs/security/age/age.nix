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
  flake.modules.nixos.age = sharedModule;
  flake.modules.darwin.age = sharedModule;
}
