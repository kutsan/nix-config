{
  flake.modules.homeManager.sbx = {
    sbx.kits.network-policy = {
      displayName = "Network policy";
      description = "Sites every sandbox may reach";

      capabilities = [
        {
          type = "com.docker.sandbox/network-policy@2";
          config.runtime = {
            allow = [
              "api.flakehub.com"
              "api.github.com"
              "cache.nixos.org"
              "channels.nixos.org"
              "cli.github.com"
              "codeload.github.com"
              "download.docker.com"
              "flake-archives.flakehub.com"
              "flakehub.com"
              "github.com"
              "install.determinate.systems"
              "nixos.org"
              "raw.githubusercontent.com"
              "registry.npmjs.org"
              "release-assets.githubusercontent.com"
              "releases.nixos.org"
            ];
          };
        }
      ];
    };
  };
}
