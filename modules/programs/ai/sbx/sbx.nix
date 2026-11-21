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

      mkKit =
        name:
        { descriptor, files, ... }:
        let
          descriptorFile = pkgs.concatText "${name}.yaml" [
            (pkgs.writeText "kit-syntax" "# syntax=docker/sandbox-kit:3\n")
            (yaml.generate "${name}-kit.yaml" (
              {
                schemaVersion = "3";
                kind = "mixin";
              }
              // descriptor
            ))
          ];
        in
        pkgs.runCommand "sbx-kit-${name}" { } ''
          mkdir --parents "$out"/${lib.escapeShellArg name}
          cp ${descriptorFile} "$out"/${lib.escapeShellArg "${name}/${name}.yaml"}
          ${lib.concatLines (
            lib.mapAttrsToList (
              path: source:
              ''cp --recursive ${lib.escapeShellArg source} "$out"/${lib.escapeShellArg "${name}/${path}"}''
            ) files
          )}
        '';

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

        kits = lib.mapAttrsToList (name: kit: "${mkKit name kit}/${name}") config.sbx.kits;
      };
    in
    {
      options.sbx.kits = lib.mkOption {
        type = lib.types.attrsOf (
          lib.types.submodule {
            options = {
              descriptor = lib.mkOption {
                type = lib.types.raw;
              };

              files = lib.mkOption {
                type = lib.types.attrsOf lib.types.path;
                default = { };
              };
            };
          }
        );
        default = { };
      };

      config = {
        home.sessionVariables.SBX_NO_TELEMETRY = "1";

        home.file.".sbxenv.yaml".source = environment;
      };
    };
}
