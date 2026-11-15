{
  flake.modules.homeManager.ssh = {
    programs.ssh = {
      enable = true;
      enableDefaultConfig = false;

      extraOptionOverrides = {
        UserKnownHostsFile = [
          "~/.ssh/known_hosts"
          "~/.ssh/known_hosts-common"
        ];
        ServerAliveInterval = 15;
        IdentitiesOnly = true;
        HashKnownHosts = true;
      };

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
