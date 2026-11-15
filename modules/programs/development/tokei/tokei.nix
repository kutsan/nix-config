let
  sharedModule =
    { pkgs, ... }:
    {
      environment.systemPackages = with pkgs; [
        tokei
      ];
    };
in
{
  flake.modules.nixos.tokei = sharedModule;
  flake.modules.darwin.tokei = sharedModule;
}
