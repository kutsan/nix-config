let
  packages =
    { pkgs, ... }:
    {
      environment.systemPackages = with pkgs; [
        neovim
        tree-sitter
      ];
    };
in
{
  flake.modules.nixos.base = packages;

  flake.modules.darwin.base = {
    imports = [ packages ];

    homebrew.casks = [
      "zed"
    ];
  };
}
