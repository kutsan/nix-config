{ inputs, ... }:
{
  perSystem =
    { pkgs, ... }:
    {
      checks.shell-lint =
        pkgs.runCommand "check-shell-lint" { nativeBuildInputs = [ pkgs.shellcheck ]; }
          ''
            cd ${inputs.self}
            find . -type f \( -name '*.sh' -o -name '*.zsh' \) -print0 |
              xargs --null --no-run-if-empty shellcheck --
            touch "$out"
          '';
    };
}
