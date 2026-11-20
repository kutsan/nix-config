{ inputs, ... }:
{
  perSystem =
    { lib, pkgs, ... }:
    {
      checks.workflow-security = pkgs.runCommand "check-workflow-security" { } ''
        cd ${inputs.self}
        ${lib.getExe pkgs.zizmor} --offline --strict-collection .github/workflows/
        touch "$out"
      '';

      apps.workflow-security-online = {
        program = pkgs.writeShellApplication {
          name = "workflow-security-online";
          runtimeInputs = with pkgs; [
            gh
            git
            zizmor
          ];
          inheritPath = false;
          text = ''
            cd "$(git rev-parse --show-toplevel)"

            if [[ -z "''${GH_TOKEN:-}''${GITHUB_TOKEN:-}" ]]; then
              if ! GH_TOKEN=$(gh auth token --hostname github.com 2> /dev/null); then
                printf '%s\n' "zizmor's online audits need a GitHub token. Log in with gh auth login, or set GH_TOKEN." >&2
                exit 1
              fi
              export GH_TOKEN
            fi

            zizmor --strict-collection .github/workflows/
          '';
        };
        meta.description = "Audit the GitHub workflows with network access";
      };
    };
}
