{ inputs, ... }:
{
  perSystem =
    { lib, pkgs, ... }:
    {
      checks.shell-lint = pkgs.runCommand "check-shell-lint" { } ''
        cd ${inputs.self}
        find . -type f \( -name '*.sh' -o -name '*.zsh' \) -print0 |
          xargs --null --no-run-if-empty ${lib.getExe pkgs.shellcheck} --
        touch "$out"
      '';
    };
}
