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

      mkKit =
        { name, descriptor }:
        pkgs.concatText "${name}.yaml" [
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

        kits = map (name: "${config.xdg.configHome}/${kitsDirectory}/${name}") (
          builtins.attrNames config.sbx.kits
        );
      };
    in
    {
      options.sbx.kits = lib.mkOption {
        type = lib.types.attrsOf lib.types.raw;
        default = { };
      };

      config = {
        home.sessionVariables.SBX_NO_TELEMETRY = "1";

        home.file.".sbxenv.yaml".source = environment;

        home.activation.sbxSkills = lib.hm.dag.entryAfter [ "writeBoundary" ] ''
          run mkdir -p "$HOME/Library/Application Support/com.docker.sandboxes/sandboxes/agent-skills"
          run ${lib.getExe pkgs.rsync} $VERBOSE_ARG --archive --delete --chmod=u+w \
            ${pkgs.local.kutsan-skills}/share/skills/ "$HOME/Library/Application Support/com.docker.sandboxes/sandboxes/agent-skills/"
        '';

        xdg.configFile = lib.mapAttrs' (
          name: descriptor:
          lib.nameValuePair "${kitsDirectory}/${name}/${name}.yaml" {
            source = mkKit { inherit name descriptor; };
          }
        ) config.sbx.kits;
      };
    };
}
