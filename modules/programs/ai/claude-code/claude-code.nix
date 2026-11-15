{
  flake.modules.homeManager.claude-code =
    { config, ... }:
    {
      programs.claude-code = {
        enable = true;
        package = null;

        configDir = "${config.xdg.configHome}/claude";
        context = ../../../system/settings/agents/AGENTS.md;

        settings = {
          model = "opus";
          effortLevel = "xhigh";
          tui = "fullscreen";
          theme = "auto";
          editorMode = "vim";

          attribution = {
            commit = "";
            pr = "";
          };

          env = {
            CLAUDE_CODE_ENABLE_TELEMETRY = "0";
          };

          spinnerVerbs = {
            mode = "replace";
            verbs = [ "Working" ];
          };

          syncClaudeAiPlugins = false;
          syncClaudeAiSkills = false;

          enabledPlugins = {
            "security-guidance@claude-plugins-official" = true;
            "claude-code-setup@claude-plugins-official" = true;
            "mattpocock-skills@claude-plugins-official" = true;
          };
        };
      };

      home.sessionVariables.CLAUDE_CODE_DISABLE_TERMINAL_TITLE = "1";
    };
}
