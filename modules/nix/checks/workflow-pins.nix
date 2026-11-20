{ inputs, ... }:
{
  perSystem =
    { pkgs, ... }:
    {
      checks.workflow-pins =
        pkgs.runCommand "check-workflow-pins"
          {
            nativeBuildInputs = with pkgs; [
              pinact
              writableTmpDirAsHomeHook
            ];
          }
          ''
            cd ${inputs.self}
            pinact run --fix=false --no-api
            touch "$out"
          '';

      apps.workflow-pins-update = {
        program = pkgs.writeShellApplication {
          name = "workflow-pins-update";
          runtimeInputs = with pkgs; [
            git
            pinact
          ];
          inheritPath = false;
          text = ''
            cd "$(git rev-parse --show-toplevel)"
            pinact run --update
          '';
        };
        meta.description = "Update the pinned GitHub Actions";
      };
    };
}
