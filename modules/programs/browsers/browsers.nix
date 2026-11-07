{ inputs, ... }:
{
  flake.modules.darwin.browsers = {
    homebrew.casks = [
      "google-chrome"
    ];

    home-manager.sharedModules = [ inputs.self.modules.homeManager.browsers ];
  };

  flake.modules.homeManager.browsers = {
    xdg.configFile."chromium/modern-for-hacker-news/config.json".source =
      ./extensions/modern-for-hacker-news/config.json;
  };
}
