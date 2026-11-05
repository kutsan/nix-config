{ inputs, ... }:
{
  flake.modules.darwin.personal = {
    imports = with inputs.self.modules.darwin; [
      system-default

      kutsan

      ai
      app-store
      asimov
      backup
      browsers
      cli
      cloud
      communication
      containers
      databases
      design
      dev-tools
      direnv
      disks
      downloads
      editors
      encryption
      finance
      fonts
      git
      keyboard
      media
      network
      notes
      reading
      sketchybar
      skhd
      terminal
      utilities
      yabai
      zsh
    ];

    system.stateVersion = 7;
  };
}
