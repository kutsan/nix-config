{
  perSystem =
    { pkgs, mkSandboxCheck, ... }:
    {
      checks.workflow-lint = mkSandboxCheck "workflow-lint" {
        tools = with pkgs; [
          actionlint
          shellcheck
        ];
        script = ''
          actionlint .github/workflows/*.yaml
        '';
      };
    };
}
