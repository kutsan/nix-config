{ inputs, ... }:
{
  flake.modules.darwin.zed.nixpkgs.overlays = [ inputs.zed-extensions.overlays.default ];
  flake.modules.nixos.zed.nixpkgs.overlays = [ inputs.zed-extensions.overlays.default ];

  flake.modules.homeManager.zed =
    { lib, pkgs, ... }:
    let
      extensionNames = [
        "dockerfile"
        "git-firefly"
        "github-actions"
        "harper"
        "html"
        "lua"
        "markdown-oxide"
        "nix"
        "rumdl"
        "stylelint"
        "symbols"
        "terraform"
        "toml"
        "tombi"
        "tsgo"
        "typos"
        "typst"
      ];
    in
    {
      imports = [ inputs.zed-extensions.homeManagerModules.default ];

      programs.zed-editor-extensions = {
        enable = true;
        packages = map (extensionName: pkgs.zed-extensions.${extensionName}) extensionNames;
      };

      programs.zed-editor.userSettings.auto_update_extensions = lib.genAttrs extensionNames (_: false);
    };
}
