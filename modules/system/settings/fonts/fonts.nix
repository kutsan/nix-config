let
  sharedModule =
    { pkgs, ... }:
    {
      fonts.packages = [
        pkgs.local.ia-writer-fonts
        pkgs.nerd-fonts.symbols-only
      ];
    };
in
{
  flake.modules.nixos.fonts = sharedModule;
  flake.modules.darwin.fonts = sharedModule;
}
