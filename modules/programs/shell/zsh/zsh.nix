{ inputs, ... }:
let
  sharedModule = {
    programs.zsh = {
      enable = true;
      enableGlobalCompInit = false;
      enableBashCompletion = false;
      promptInit = "";
    };

    home-manager.sharedModules = [ inputs.self.modules.homeManager.zsh ];
  };
in
{
  flake.modules.nixos.zsh = sharedModule;

  flake.modules.darwin.zsh =
    { pkgs, ... }:
    {
      imports = [ sharedModule ];

      environment.shells = [ pkgs.zsh ];

      programs.zsh.interactiveShellInit = "disable log";
    };

  flake.modules.homeManager.zsh =
    {
      config,
      lib,
      pkgs,
      ...
    }:
    {
      programs.zsh = {
        enable = true;
        package = null;
        enableCompletion = true;
        completionInit = "source ${./compinit.zsh}";

        profileExtra = "source ${./zprofile.zsh}";
        loginExtra = "source ${./zlogin.zsh}";

        initContent = lib.mkMerge [
          (lib.mkOrder 950 "source ${./config}/init.zsh")

          (lib.mkOrder 1100 ''
            source ${./plugins/pure.zsh}
            source ${pkgs.pure-prompt}/share/zsh/site-functions/async
            source ${pkgs.pure-prompt}/share/zsh/site-functions/prompt_pure_setup

            source ${./plugins/fzf-tab.zsh}
            source ${pkgs.zsh-fzf-tab}/share/fzf-tab/fzf-tab.plugin.zsh

            source ${pkgs.zsh-autosuggestions}/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh

            source ${pkgs.zsh-autopair}/share/zsh/zsh-autopair/autopair.zsh

            source ${pkgs.zsh-fast-syntax-highlighting}/share/zsh/plugins/fast-syntax-highlighting/fast-syntax-highlighting.plugin.zsh
            source ${./plugins/fast-syntax-highlighting.zsh}
          '')
        ];
      };

      home.sessionVariables = {
        # Zsh Config
        SHELL_SESSIONS_DISABLE = "1";

        # Defaults
        LANG = "en_US.UTF-8";
        EDITOR = "nvim";
        GUI_EDITOR = "zed";
        FILE_MANAGER = "yazi";

        # ls
        LS_COLORS = lib.fileContents ./ls-colors;

        # Telemetry
        DISABLE_TELEMETRY = "1";
        DO_NOT_TRACK = "1";

        # npm
        NPM_CONFIG_INIT_AUTHOR_NAME = "Kutsan Kaplan";
        NPM_CONFIG_INIT_AUTHOR_EMAIL = "me@kutsan.dev";
        NPM_CONFIG_INIT_AUTHOR_URL = "https://kutsan.dev";
        NPM_CONFIG_INIT_LICENSE = "MIT";
        NPM_CONFIG_INIT_VERSION = "0.0.0";
        NPM_CONFIG_SIGN_GIT_TAG = "true";

        # Rust
        CARGO_HOME = "${config.xdg.dataHome}/cargo";
        RUSTUP_HOME = "${config.xdg.dataHome}/rustup";
      };

      home.sessionPath = [
        # Rust
        "${config.home.sessionVariables.CARGO_HOME}/bin"
        # Local Executables
        "${config.home.homeDirectory}/.local/bin"
      ];

      # Hides the "Last login" message `login` prints when a terminal starts the shell.
      home.file.".hushlogin".text = "";
    };
}
