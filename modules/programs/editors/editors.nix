let
  sharedModule =
    { pkgs, ... }:
    {
      environment.systemPackages = with pkgs; [
        neovim
        tree-sitter
      ];
    };
in
{
  flake.modules.nixos.editors = sharedModule;

  flake.modules.darwin.editors = sharedModule;
}
