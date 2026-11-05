{
  flake.modules.darwin.yabai =
    { pkgs, ... }:
    {
      services.yabai = {
        enable = true;
        package = pkgs.yabai.overrideAttrs (
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
      };
    };
}
