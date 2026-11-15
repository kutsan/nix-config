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

      asimov
      audacity
      backblaze
      blender
      claude
      datagrip
      discord
      docker-desktop
      figma
      fonts
      ghostty
      google-chrome
      handbrake
      iina
      insta360-link-controller
      keepingyouawake
      keyboard
      ledger-wallet
      mas
      mole-cleaner
      neodisk
      netnewswire
      obs
      orcaslicer
      proxyman
      qmk
      sbx
      sf-symbols
      sketchybar
      skhd
      skim
      tldraw
      transmission
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
