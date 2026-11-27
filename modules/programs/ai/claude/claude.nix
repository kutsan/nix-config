{ inputs, ... }:
{
  flake.modules.darwin.claude = {
    homebrew.casks = [
      "claude"
    ];

    home-manager.sharedModules = [ inputs.self.modules.homeManager.claude ];
  };

  flake.modules.homeManager.claude =
    {
      config,
      lib,
      pkgs,
      ...
    }:
    let
      settings = {
        mcpServers = lib.mapAttrs (
          _: server: lib.hm.mcp.transformMcpServer { inherit server; }
        ) config.programs.mcp.servers;
      };
    in
    {
      home.activation.claudeDesktopConfig = lib.hm.dag.entryAfter [ "writeBoundary" ] (
        lib.hm.generators.mkImpureConfigMerger {
          inherit pkgs;
          format = "json";
          empty = "{}";
          jqOperation = "$dynamic | .mcpServers = $static.mcpServers";
          path = "${config.home.homeDirectory}/Library/Application Support/Claude/claude_desktop_config.json";
          staticSettings = (pkgs.formats.json { }).generate "claude-desktop-config.json" settings;
        }
      );
    };
}
