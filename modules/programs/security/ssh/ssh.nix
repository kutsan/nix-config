{
  flake.modules.homeManager.ssh = {
    programs.ssh = {
      enable = true;
      enableDefaultConfig = false;

      # Written above every host, so they apply everywhere.
      extraOptionOverrides = {
        UserKnownHostsFile = [
          "~/.ssh/known_hosts"
          "~/.ssh/known_hosts-common"
        ];
        ServerAliveInterval = 15;
        IdentitiesOnly = true;
        HashKnownHosts = true;
      };

      # Hosts kept only on this machine. Included before the hosts below, so they win.
      includes = [ "conf/hosts-local.ssh" ];

      settings.github = {
        User = "git";
        HostName = "github.com";
        IdentityFile = "~/.ssh/keys/github";
      };
    };

    home.file.".ssh/known_hosts-common".source = ./known_hosts-common;
  };
}
