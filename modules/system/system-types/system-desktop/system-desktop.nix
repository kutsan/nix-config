{ inputs, ... }:
{
  flake.modules.nixos.system-desktop = {
    imports = with inputs.self.modules.nixos; [
      system-cli

      fonts
      zed
    ];

    home-manager.sharedModules = [ inputs.self.modules.homeManager.system-desktop ];
  };

  flake.modules.darwin.system-desktop = {
    imports = with inputs.self.modules.darwin; [
      system-cli

      apple-mail
      asimov
      claude
      datagrip
      desktop-environment
      docker-desktop
      figma
      file-manager
      fonts
      ghostty
      google-chrome
      hand-mirror
      iina
      insta360-link-controller
      keepingyouawake
      keyboard
      mas
      mole-cleaner
      neodisk
      proxyman
      qmk
      sbx
      sf-symbols
      sketchybar
      skhd
      skim
      tldraw
      ukelele
      wallpapers
      yabai
      zed
    ];

    system.defaults.CustomUserPreferences = {
      "com.apple.onetimepasscodes".DeleteVerificationCodes = true;
      "com.apple.suggestions".AppCanShowSiriSuggestionsBlacklist = [ "com.apple.AddressBook" ];
    };

    home-manager.sharedModules = [
      inputs.self.modules.homeManager.system-desktop
      {
        manualSetup.system-desktop = [
          "In **System Settings > Accessibility > Zoom**, turn on **Use scroll gesture with modifier keys to zoom**."
          "In **System Settings > Lock Screen**, set **Require password after screen saver begins** to **Immediately**."
          "Turn on unlocking with Apple Watch."
        ];
      }
    ];
  };

  flake.modules.homeManager.system-desktop = {
    imports = with inputs.self.modules.homeManager; [
      wallpapers
    ];
  };
}
