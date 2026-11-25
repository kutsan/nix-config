{
  flake.modules.homeManager.sbx =
    { pkgs, ... }:
    let
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
    in
    {
      sbx.kits.claude-config = {
        descriptor = {
          displayName = "Claude Code configuration";
          description = "Claude Code settings and the access its plugins need";

          build = ''
            FROM scratch
            COPY nix-config.json /etc/claude-code/managed-settings.d/nix-config.json
          '';

          capabilities = [
            {
              type = "com.docker.sandbox/network-policy@2";
              config.runtime = {
                allow = [
                  "files.pythonhosted.org"
                  "pypi.org"
                ];
              };
            }
          ];
        };

        files."nix-config.json" = (pkgs.formats.json { }).generate "nix-config.json" settings;
      };
    };
}
