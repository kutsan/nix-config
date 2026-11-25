{ inputs, ... }:
let
  systemCli = class: {
    imports = with inputs.self.modules.${class}; [
      system-default

      act
      age
      btop
      devcontainer
      direnv
      dive
      exiftool
      fd
      ffmpeg
      fx
      gh
      git
      git-standup
      google-cloud-sdk
      google-cloud-sql-proxy
      gptfdisk
      imagemagick
      jq
      neovim
      nmap
      ripgrep
      sops
      tokei
      tree
      trippy
      zk
      zsh
    ];

    home-manager.sharedModules = [ inputs.self.modules.homeManager.system-cli ];
  };
in
{
  flake.modules.nixos.system-cli = systemCli "nixos";
  flake.modules.darwin.system-cli = systemCli "darwin";

  flake.modules.homeManager.system-cli = {
    imports = with inputs.self.modules.homeManager; [
      atuin
      bat
      delta
      editorconfig
      fzf
      gnupg
      lazydocker
      lazygit
      less
      mise
      npm
      rumdl
      rust
      ssh
      yazi
      zoxide
    ];
  };
}
