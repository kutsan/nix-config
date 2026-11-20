{ inputs, ... }:
{
  perSystem =
    { lib, pkgs, ... }:
    {
      checks.workflow-lint = pkgs.runCommand "check-workflow-lint" { } ''
        cd ${inputs.self}
        ${lib.getExe pkgs.actionlint} .github/workflows/*.yaml
        touch "$out"
      '';
    };
}
