{ inputs, ... }:
{
  flake.modules.darwin.work-macbook =
    { config, ... }:
    {
      imports = with inputs.self.modules.darwin; [
        system-desktop
        work
      ];

      system.defaults.dock = {
        persistent-apps = [
          "/System/Applications/Apps.app"
          "/Applications/Google Chrome.app"
          "/System/Volumes/Preboot/Cryptexes/App/System/Applications/Safari.app"
          "/System/Applications/Reminders.app"
          "/System/Applications/Notes.app"
          "/System/Applications/Calendar.app"
          "/System/Applications/Messages.app"
          "/System/Applications/Mail.app"
          "/System/Applications/Music.app"
          "/Applications/Zed.app"
          "/Applications/Ghostty.app"
        ];

        persistent-others = [
          {
            folder = {
              path = "${config.system.primaryUserHome}/Downloads";
              arrangement = "date-added";
              displayas = "stack";
              showas = "grid";
            };
          }
        ];
      };

      system.stateVersion = 7;
    };
}
