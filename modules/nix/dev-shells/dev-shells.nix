{
  perSystem =
    { pkgs, ... }:
    {
      devShells.default = pkgs.mkShellNoCC {
        packages = with pkgs; [
          bash
          catppuccin-whiskers
          just
          nh
          qmk
        ];
      };
    };
}
