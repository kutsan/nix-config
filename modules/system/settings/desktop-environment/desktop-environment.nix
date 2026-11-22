let
  darwinSystemDefaults = {
    dock = {
      autohide = true;
      mineffect = "scale";
      mru-spaces = false;
    };

    WindowManager.EnableStandardClickToShowDesktop = false;

    controlcenter.BatteryShowPercentage = true;

    NSGlobalDomain = {
      _HIHideMenuBar = true;
      AppleIconAppearanceTheme = "ClearAutomatic";
      AppleShowScrollBars = "WhenScrolling";
    };

    CustomUserPreferences.NSGlobalDomain = {
      AppleMenuBarVisibleInFullscreen = false;
      SLSMenuBarUseBlurredAppearance = true;
    };
  };
in
{
  flake.modules.darwin.desktop-environment = {
    system.defaults = darwinSystemDefaults;

    home-manager.sharedModules = [
      {
        xdg.stateFile."desktop-environment/darwin-system-defaults.json" = {
          text = builtins.toJSON darwinSystemDefaults;
          onChange = ''
            /usr/bin/killall -q ControlCenter SystemUIServer WindowManager || true
          '';
        };
      }
    ];
  };
}
