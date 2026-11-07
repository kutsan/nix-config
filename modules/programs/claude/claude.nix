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
        mcpServers = {
          goodlinks = {
            command = "/Applications/GoodLinks.app/Contents/MacOS/CLI/goodlinks";
            args = [ "mcp-server" ];
          };
        };
      };
    in
    {
      home.activation.claudeDesktopConfig = lib.hm.dag.entryAfter [ "writeBoundary" ] (
        lib.hm.generators.mkImpureConfigMerger {
          inherit pkgs;
          format = "json";
          empty = "{}";
          jqOperation = "$dynamic | .mcpServers += $static.mcpServers";
          path = "${config.home.homeDirectory}/Library/Application Support/Claude/claude_desktop_config.json";
          staticSettings = (pkgs.formats.json { }).generate "claude-desktop-config.json" settings;
        }
      );
    };
}
