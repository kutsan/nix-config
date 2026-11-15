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
      yaml = pkgs.formats.yaml { };

      kitsDirectory = "sbx/kits";

      claudeSettings = lib.recursiveUpdate config.programs.claude-code.settings {
        enabledPlugins."kutsan-skills@synced" = false;
      };

      kits = {
        claude-config = {
          displayName = "Claude Code configuration";
          description = "Claude Code settings, instructions and the access its plugins need";

          capabilities = [
            {
              type = "com.docker.sandbox/lifecycle@1";
              config.files = [
                {
                  path = "/etc/claude-code/managed-settings.d/nix-config.json";
                  content = builtins.toJSON claudeSettings;
                  mode = "0644";
                  description = "Claude Code settings, as managed settings";
                }
              ];
            }

            {
              type = "com.docker.sandbox/agent-context@2";
              config = {
                filename = "CLAUDE.md";
                directory = "/home/agent/.claude";
                content = builtins.readFile ../../../system/settings/agents/AGENTS.md;
              };
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

        network-policy = {
          displayName = "Network policy";
          description = "Sites every sandbox may reach, and sites none may";

          capabilities = [
            {
              type = "com.docker.sandbox/network-policy@2";
              config.runtime = {
                allow = [
                  "api.flakehub.com"
                  "api.github.com"
                  "cache.nixos.org"
                  "channels.nixos.org"
                  "cli.github.com"
                  "codeload.github.com"
                  "download.docker.com"
                  "flake-archives.flakehub.com"
                  "flakehub.com"
                  "github.com"
                  "install.determinate.systems"
                  "nixos.org"
                  "raw.githubusercontent.com"
                  "registry.npmjs.org"
                  "release-assets.githubusercontent.com"
                  "releases.nixos.org"
                ];
              };
            }
          ];
        };
      };

      mkKit =
        { name, descriptor }:
        pkgs.concatText "spec.yaml" [
          (pkgs.writeText "kit-syntax" "# syntax=docker/sandbox-kit:3\n")
          (yaml.generate "${name}-kit.yaml" (
            {
              schemaVersion = "3";
              kind = "mixin";
            }
            // descriptor
          ))
        ];

      environment = yaml.generate "sbxenv.yaml" {
        schemaVersion = "1";

        args.agent = {
          default = "claude";
          enum = [
            "claude"
            "codex"
          ];
        };

        agent = "\${{ env.args.agent }}";
        workspace = "\${{ env.projectDir }}";

        kits = map (
          name:
          "./${lib.removePrefix "${config.home.homeDirectory}/" config.xdg.configHome}/${kitsDirectory}/${name}"
        ) (builtins.attrNames kits);
      };
    in
    {
      home.sessionVariables.SBX_NO_TELEMETRY = "1";

      home.file = {
        ".sbxenv.yaml".source = environment;

        "Library/Application Support/com.docker.sandboxes/sandboxes/agent-skills".source =
          config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/.agents/skills";
      };

      xdg.configFile = lib.mapAttrs' (
        name: descriptor:
        lib.nameValuePair "${kitsDirectory}/${name}/spec.yaml" {
          source = mkKit { inherit name descriptor; };
        }
      ) kits;
    };
}
