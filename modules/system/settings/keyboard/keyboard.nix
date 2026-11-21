{ inputs, ... }:
{
  flake.modules.darwin.keyboard = {
    system.keyboard = {
      enableKeyMapping = true;
      remapCapsLockToEscape = true;
    };

    system.defaults = {
      NSGlobalDomain.AppleKeyboardUIMode = 2;
      hitoolbox.AppleFnUsageType = "Do Nothing";
    };

    home-manager.sharedModules = [ inputs.self.modules.homeManager.keyboard ];
  };

  flake.modules.homeManager.keyboard =
    { lib, pkgs, ... }:
    let
      layouts = lib.fileset.toSource {
        root = ./layouts;
        fileset = lib.fileset.fileFilter (file: file.hasExt "keylayout") ./layouts;
      };
    in
    {
      home.activation.keyboardLayouts = lib.hm.dag.entryAfter [ "writeBoundary" ] ''
        run mkdir -p "$HOME/Library/Keyboard Layouts"
        run ${lib.getExe pkgs.rsync} $VERBOSE_ARG --archive --delete --chmod=u+w \
          ${layouts}/ "$HOME/Library/Keyboard Layouts/"
      '';
    };
}
