{ inputs, ... }:
{
  perSystem =
    { config, pkgs, ... }:
    {
      _module.args = {
        mkSandboxCheck =
          name:
          { tools, script }:
          pkgs.runCommand "check-${name}" { nativeBuildInputs = [ pkgs.writableTmpDirAsHomeHook ] ++ tools; }
            ''
              cd ${inputs.self}
              ${script}
              touch "$out"
            '';

        mkEvaluationCheck =
          name: value:
          builtins.deepSeq value (
            pkgs.runCommand "check-${name}" { } ''
              touch "$out"
            ''
          );

        mkFormatterCheck =
          name:
          (config.formatter.check inputs.self).overrideAttrs (previousAttrs: {
            name = "check-${name}-format";
            env = previousAttrs.env // {
              TREEFMT_FORMATTERS = name;
            };
          });

        mkOnlineApp =
          name:
          { tools, script }:
          {
            program = pkgs.writeShellApplication {
              inherit name;
              runtimeInputs = [ pkgs.git ] ++ tools;
              inheritPath = false;
              text = ''
                cd "$(git rev-parse --show-toplevel)"
                ${script}
              '';
            };
            meta.description = "Run ${name} with network access";
          };
      };
    };
}
