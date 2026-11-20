{
  perSystem =
    {
      pkgs,
      mkSandboxCheck,
      mkOnlineApp,
      ...
    }:
    {
      checks.workflow-pins = mkSandboxCheck "workflow-pins" {
        tools = [ pkgs.pinact ];
        script = ''
          pinact run --fix=false --no-api
        '';
      };

      apps.workflow-pins-online = mkOnlineApp "workflow-pins-online" {
        tools = [ pkgs.pinact ];
        script = ''
          pinact run --check --verify
        '';
      };

      apps.workflow-pins-update = mkOnlineApp "workflow-pins-update" {
        tools = [ pkgs.pinact ];
        script = ''
          pinact run --update
        '';
      };
    };
}
