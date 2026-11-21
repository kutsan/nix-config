{
  flake.modules.homeManager.sbx =
    { config, pkgs, ... }:
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

        files."nix-config.json" =
          (pkgs.formats.json { }).generate "nix-config.json"
            config.programs.claude-code.settings;
      };
    };
}
