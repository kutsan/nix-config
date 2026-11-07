{ inputs, ... }:
{
  flake.modules.darwin.backblaze = {
    homebrew.casks = [
      "backblaze"
    ];

    home-manager.sharedModules = [ inputs.self.modules.homeManager.backblaze ];
  };

  flake.modules.homeManager.backblaze = {
    xdg.configFile."backblaze/bzexcluderules_editable.xml".source = ./bzexcluderules_editable.xml;
  };
}
