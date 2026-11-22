{
  flake.modules.darwin.yabai =
    { lib, pkgs, ... }:
    let
      yabaiPackage = pkgs.yabai.overrideAttrs (
        finalAttrs: _: {
          version = "7.3.1";
          src = pkgs.fetchFromGitHub {
            owner = "Christian-SC26";
            repo = "yabai";
            tag = "v${finalAttrs.version}";
            hash = "sha256-IKJa7GAbckQz8s/c4StT8mJ71W7CzB2CQMlIzUpW9io=";
          };
        }
      );

      autoUnzoomScript = pkgs.writeShellApplication {
        name = "auto-unzoom";
        runtimeInputs = [
          pkgs.jq
          yabaiPackage
        ];
        text = builtins.readFile ./scripts/auto-unzoom.sh;
      };

      configDirectory = pkgs.linkFarm "yabai-config" {
        yabairc = ./yabairc;
        config = ./config;
        "scripts/auto-unzoom.sh" = lib.getExe autoUnzoomScript;
      };
    in
    {
      services.yabai = {
        enable = true;
        package = yabaiPackage;
        extraConfig = "${configDirectory}/yabairc";
      };
    };
}
