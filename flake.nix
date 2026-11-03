{
  inputs = {
    nixpkgs = {
      url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    };
  };

  outputs =
    { nixpkgs, ... }:
    let
      forEachSystem = nixpkgs.lib.genAttrs [
        "aarch64-darwin"
        "aarch64-linux"
        "x86_64-linux"
      ];
    in
    {
      formatter = forEachSystem (system: nixpkgs.legacyPackages.${system}.nixfmt-tree);

      devShells = forEachSystem (
        system:
        let
          pkgs = nixpkgs.legacyPackages.${system};

          base = pkgs.mkShellNoCC {
            packages = with pkgs; [
              actionlint
              bash
              chezmoi
              git
              just
              lua-language-server
              neovim
              nixfmt
              pinact
              selene
              shellcheck
              shfmt
              tombi
              zizmor
            ];
          };
        in
        {
          default = pkgs.mkShellNoCC {
            inputsFrom = [ base ];
            packages = with pkgs; [
              catppuccin-whiskers
              curl
              keymap-drawer
              nh
              qmk
            ];
          };

          ci = pkgs.mkShellNoCC {
            inputsFrom = [ base ];
          };
        }
      );
    };
}
