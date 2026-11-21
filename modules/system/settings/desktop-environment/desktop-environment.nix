let
  defaults = {
    dock = {
      autohide = true;
      mineffect = "scale";
      mru-spaces = false;
    };

    WindowManager.EnableStandardClickToShowDesktop = false;

    controlcenter.BatteryShowPercentage = true;

    NSGlobalDomain = {
      _HIHideMenuBar = true;
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
    system.defaults = defaults;

    home-manager.sharedModules = [
      {
        xdg.stateFile."desktop-environment/defaults.json" = {
          text = builtins.toJSON defaults;
          onChange = ''
            /usr/bin/killall -q ControlCenter SystemUIServer WindowManager || true
          '';
        };
      }
    ];
  };
}
