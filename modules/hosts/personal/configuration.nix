{ inputs, ... }:
{
  flake.modules.darwin.personal = {
    imports = with inputs.self.modules.darwin; [
      system-default

      kutsan

      app-store
      asimov
      backblaze
      browsers
      claude
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
      encryption
      finance
      fonts
      ghostty
      git
      keyboard
      media
      neovim
      network
      notes
      qmk
      reading
      sbx
      sketchybar
      skhd
      ukelele
      utilities
      yabai
      zed
      zsh
    ];

    system.stateVersion = 7;
  };
}
