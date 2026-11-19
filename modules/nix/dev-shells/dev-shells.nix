{
  perSystem =
    { pkgs, ... }:
    let
      env.NEOVIM_RUNTIME = "${pkgs.neovim-unwrapped}/share/nvim/runtime";

      sharedShell = pkgs.mkShellNoCC {
        packages = with pkgs; [
          actionlint
          bash
          git
          just
          lua-language-server
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
          inherit env;
          inputsFrom = [ sharedShell ];
          packages = with pkgs; [
            catppuccin-whiskers
            nh
            qmk
          ];
        };

        ci = pkgs.mkShellNoCC {
          inherit env;
          inputsFrom = [ sharedShell ];
        };
      };
    };
}
