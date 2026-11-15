let
  sharedModule =
    { pkgs, ... }:
    {
      environment.systemPackages = with pkgs; [
        ripgrep
      ];
    };
in
{
  flake.modules.nixos.ripgrep = sharedModule;
  flake.modules.darwin.ripgrep = sharedModule;
}
