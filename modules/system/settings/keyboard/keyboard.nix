{ inputs, ... }:
let
  darwinSystemDefaults = {
    NSGlobalDomain.AppleKeyboardUIMode = 2;
    hitoolbox.AppleFnUsageType = "Do Nothing";

    CustomUserPreferences = {
      "com.apple.HIToolbox" = {
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

      "com.apple.symbolichotkeys".AppleSymbolicHotKeys = {
        # Dock > Turn Dock hiding on/off, Cmd + Option + D
        "52" = {
          enabled = false;
          value = {
            parameters = [
              100
              2
              1572864
            ];
            type = "standard";
          };
        };

        # Input Sources > Select the previous input source, Ctrl + Space
        "60" = {
          enabled = false;
          value = {
            parameters = [
              32
              49
              262144
            ];
            type = "standard";
          };
        };

        # Input Sources > Select next source in Input menu, Ctrl + Option + Space
        "61" = {
          enabled = false;
          value = {
            parameters = [
              32
              49
              786432
            ];
            type = "standard";
          };
        };

        # Cmd + M
        "233" = {
          enabled = false;
          value = {
            parameters = [
              109
              46
              1048576
            ];
            type = "standard";
          };
        };
      };
    };
  };
in
{
  flake.modules.darwin.keyboard = {
    system.keyboard = {
      enableKeyMapping = true;
      remapCapsLockToEscape = true;
    };

    system.defaults = darwinSystemDefaults;

    home-manager.sharedModules = [
      inputs.self.modules.homeManager.keyboard
      {
        xdg.stateFile."keyboard/darwin-system-defaults.json" = {
          text = builtins.toJSON darwinSystemDefaults;
          onChange = ''
            /System/Library/PrivateFrameworks/SystemAdministration.framework/Resources/activateSettings -u
          '';
        };
      }
    ];
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
        run mkdir --parents -- "$HOME/Library/Keyboard Layouts"
        run ${lib.getExe pkgs.rsync} ''${VERBOSE_ARG:+"$VERBOSE_ARG"} --archive --delete --chmod=u+w -- \
          ${keyboardLayoutFiles}/ "$HOME/Library/Keyboard Layouts/"
      '';
    };
}
