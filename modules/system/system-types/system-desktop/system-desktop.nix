{ inputs, ... }:
{
  flake.modules.nixos.system-desktop = {
    imports = with inputs.self.modules.nixos; [
      system-cli

      fonts
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
      yabai
      zed
    ];

    home-manager.sharedModules = [ inputs.self.modules.homeManager.system-desktop ];
  };

  flake.modules.homeManager.system-desktop = {
    imports = with inputs.self.modules.homeManager; [
      wallpapers
    ];
  };
}
