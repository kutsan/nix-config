{ inputs, ... }:
let
  zedExtensionsOverlays = [
    inputs.zed-extensions.overlays.default
    (_final: prev: {
      fetch-cargo-vendor-util = prev.writers.writePython3Bin "fetch-cargo-vendor-util" {
        libraries =
          with prev.python3Packages;
          [
            requests
            tomli-w
          ]
          ++ requests.optional-dependencies.socks;
        flakeIgnore = [ "E501" ];
      } (builtins.readFile (prev.path + "/pkgs/build-support/rust/fetch-cargo-vendor-util.py"));
    })
  ];
in
{
  flake.modules.darwin.zed.nixpkgs.overlays = zedExtensionsOverlays;
  flake.modules.nixos.zed.nixpkgs.overlays = zedExtensionsOverlays;

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
