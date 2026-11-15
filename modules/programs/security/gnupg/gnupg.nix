{
  flake.modules.homeManager.gnupg =
    { config, lib, ... }:
    {
      programs.gpg = {
        enable = true;
        homedir = "${config.xdg.configHome}/gnupg";

        settings = lib.mkForce {
          no-comments = true;
          no-version = true;
        };
      };

      programs.zsh.initContent = ''
        export GPG_TTY="$TTY"
      '';
    };
}
