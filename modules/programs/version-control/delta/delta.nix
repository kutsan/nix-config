{ inputs, ... }:
{
  flake.modules.homeManager.delta = {
    programs.delta.enable = true;

    programs.git.includes = [
      { path = inputs.poisonbloom.lib.themes.delta; }
      { path = ./delta.gitconfig; }
    ];
  };
}
