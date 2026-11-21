{ inputs, ... }:
{
  perSystem =
    { pkgs, ... }:
    {
      checks.nix-lint =
        pkgs.runCommand "check-nix-lint" { nativeBuildInputs = [ pkgs.nixf-diagnose ]; }
          ''
            cd ${inputs.self}
            find . -type f -name '*.nix' -print0 |
              xargs --null --no-run-if-empty nixf-diagnose --
            touch "$out"
          '';
    };
}
