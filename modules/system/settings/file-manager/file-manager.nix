let
  darwinSystemDefaults = {
    NSGlobalDomain.AppleShowAllExtensions = true;

    finder = {
      AppleShowAllFiles = true;
      FXDefaultSearchScope = "SCcf";
      FXPreferredViewStyle = "Nlsv";
      FXRemoveOldTrashItems = true;
      ShowExternalHardDrivesOnDesktop = false;
      ShowRemovableMediaOnDesktop = false;
      _FXSortFoldersFirst = true;
      _FXSortFoldersFirstOnDesktop = true;
    };

    CustomUserPreferences."com.apple.desktopservices" = {
      DSDontWriteNetworkStores = true;
      DSDontWriteUSBStores = true;
    };
  };
in
{
  flake.modules.darwin.file-manager = {
    system.defaults = darwinSystemDefaults;

    home-manager.sharedModules = [
      {
        xdg.stateFile."file-manager/darwin-system-defaults.json" = {
          text = builtins.toJSON darwinSystemDefaults;
          onChange = ''
            /usr/bin/killall -q Finder || true
          '';
        };
      }
    ];
  };
}
