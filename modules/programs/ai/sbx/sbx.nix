{ inputs, ... }:
{
  flake.modules.darwin.sbx = {
    homebrew.casks = [
      "docker/tap/sbx"
    ];

    home-manager.sharedModules = [ inputs.self.modules.homeManager.sbx ];
  };

  flake.modules.homeManager.sbx =
    {
      config,
      lib,
      pkgs,
      ...
    }:
    let
      claudeKit = (pkgs.formats.yaml { }).generate "sbx-claude-kit.yaml" {
        schemaVersion = "2";
        kind = "mixin";
        name = "local-claude-code";
        displayName = "Local Claude Code";
        setup.startup = [
          {
            command = [
              "sh"
              "-c"
              (
                lib.escapeShellArgs [
                  "set"
                  "--"
                  (builtins.toJSON config.programs.claude-code.settings)
                  (builtins.readFile ../../../system/settings/agents/AGENTS.md)
                ]
                + "\n"
                + builtins.readFile ./kits/claude/startup.sh
              )
            ];
          }
        ];
      };
    in
    {
      home.sessionVariables.SBX_NO_TELEMETRY = "1";

      home.file = {
        ".sbxenv.yaml".source = ./sbxenv.yaml;

        "Library/Application Support/com.docker.sandboxes/sandboxes/agent-skills".source =
          config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/.agents/skills";
      };

      xdg.configFile."sbx/kits/claude/spec.yaml".source = claudeKit;
    };
}
