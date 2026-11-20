{
  perSystem =
    {
      pkgs,
      mkSandboxCheck,
      mkOnlineApp,
      ...
    }:
    {
      checks.workflow-security = mkSandboxCheck "workflow-security" {
        tools = [ pkgs.zizmor ];
        script = ''
          zizmor --offline --strict-collection .github/workflows/
        '';
      };

      apps.workflow-security-online = mkOnlineApp "workflow-security-online" {
        tools = [ pkgs.zizmor ];
        script = ''
          zizmor --strict-collection .github/workflows/
        '';
      };
    };
}
