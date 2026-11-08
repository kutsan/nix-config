{ inputs, ... }:
let
  sharedModule =
    { pkgs, ... }:
    {
      fonts.packages = [
        pkgs.local.ia-writer-fonts
        pkgs.nerd-fonts.symbols-only
      ];

      home-manager.sharedModules = [ inputs.self.modules.homeManager.fonts ];
    };
in
{
  flake.modules.nixos.fonts = sharedModule;
  flake.modules.darwin.fonts = sharedModule;

  flake.modules.homeManager.fonts =
    {
      config,
      lib,
      pkgs,
      ...
    }:
    let
      installPersonalFonts = pkgs.writeShellApplication {
        name = "install-personal-fonts";
        runtimeInputs = with pkgs; [
          age
          coreutils
          gnutar
          gzip
          rsync
        ];
        text = builtins.readFile ./install-personal-fonts.sh;
      };

      fontsDirectory =
        if pkgs.stdenv.hostPlatform.isDarwin then
          "${config.home.homeDirectory}/Library/Fonts"
        else
          "${config.xdg.dataHome}/fonts";
    in
    {
      home.activation.personalFonts = lib.hm.dag.entryAfter [ "writeBoundary" ] ''
        run ${lib.getExe installPersonalFonts} ${
          lib.escapeShellArgs [
            "${inputs.personal-fonts}/dist/fonts.tar.gz.age"
            config.sops.age.keyFile
            "${fontsDirectory}/Personal"
          ]
        }
      '';
    };
}
