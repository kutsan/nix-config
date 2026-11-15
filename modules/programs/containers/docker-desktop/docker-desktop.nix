{ inputs, ... }:
{
  flake.modules.darwin.docker-desktop = {
    homebrew.casks = [
      "docker-desktop"
    ];

    home-manager.sharedModules = [ inputs.self.modules.homeManager.docker-desktop ];
  };

  flake.modules.homeManager.docker-desktop =
    { lib, ... }:
    {
      programs.zsh.initContent = lib.mkOrder 560 ''
        fpath=(
          "$HOME/.docker/completions"
          $fpath
        )
      '';
    };
}
