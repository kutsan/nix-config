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
      mise
      neovim
      nmap
      nodejs
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
      agents
      atuin
      bat
      claude-code
      delta
      editorconfig
      fzf
      gnupg
      lazydocker
      lazygit
      less
      ssh
      yazi
      zoxide
    ];
  };
}
