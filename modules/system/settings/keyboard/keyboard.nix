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

      CustomUserPreferences."com.apple.HIToolbox" = {
        AppleSelectedInputSources = [
          {
            "Bundle ID" = "com.apple.PressAndHold";
            InputSourceKind = "Non Keyboard Input Method";
          }
          # The id and name of the <keyboard> element in `"ABC User.keylayout"` file
          {
            InputSourceKind = "Keyboard Layout";
            "KeyboardLayout ID" = -2080;
            "KeyboardLayout Name" = "ABC – User";
          }
        ];

        AppleCurrentKeyboardLayoutInputSourceID = "org.unknown.keylayout.ABC–User";
      };
    };

    home-manager.sharedModules = [ inputs.self.modules.homeManager.keyboard ];
  };

  flake.modules.homeManager.keyboard =
    { lib, pkgs, ... }:
    let
      keyboardLayoutFiles = lib.fileset.toSource {
        root = ./layouts;
        fileset = lib.fileset.fileFilter (file: file.hasExt "keylayout") ./layouts;
      };
    in
    {
      home.activation.keyboardLayouts = lib.hm.dag.entryAfter [ "writeBoundary" ] ''
        run mkdir -p "$HOME/Library/Keyboard Layouts"
        run ${lib.getExe pkgs.rsync} $VERBOSE_ARG --archive --delete --chmod=u+w \
          ${keyboardLayoutFiles}/ "$HOME/Library/Keyboard Layouts/"
      '';
    };
}
