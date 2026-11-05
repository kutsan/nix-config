{
  perSystem =
    { pkgs, ... }:
    let
      sharedShell = pkgs.mkShellNoCC {
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
      devShells = {
        default = pkgs.mkShellNoCC {
          inputsFrom = [ sharedShell ];
          packages = with pkgs; [
            catppuccin-whiskers
            curl
            keymap-drawer
            nh
            qmk
          ];
        };

        ci = pkgs.mkShellNoCC {
          inputsFrom = [ sharedShell ];
        };
      };
    };
}
