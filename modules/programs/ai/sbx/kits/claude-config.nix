{
  flake.modules.homeManager.sbx =
    { config, ... }:
    {
      sbx.kits.claude-config = {
        displayName = "Claude Code configuration";
        description = "Claude Code settings and the access its plugins need";

        capabilities = [
          {
            type = "com.docker.sandbox/lifecycle@1";
            config.install = [
              {
                command = [
                  "sh"
                  "-c"
                  ''umask 022 && mkdir --parents /etc/claude-code/managed-settings.d && printf '%s\n' "$1" > /etc/claude-code/managed-settings.d/nix-config.json''
                  "sh"
                  (builtins.toJSON config.programs.claude-code.settings)
                ];
                user = "0";
                description = "Claude Code settings, as managed settings";
              }
            ];
          }

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
    };
}
