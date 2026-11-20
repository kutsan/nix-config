{ inputs, ... }:
{
  perSystem =
    { pkgs, ... }:
    {
      checks.workflow-lint =
        pkgs.runCommand "check-workflow-lint" { nativeBuildInputs = [ pkgs.actionlint ]; }
          ''
            cd ${inputs.self}
            actionlint .github/workflows/*.yaml
            touch "$out"
          '';
    };
}
