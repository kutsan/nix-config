{
  flake.modules.homeManager.delta =
    { lib, ... }:
    let
      configDirectory = lib.fileset.toSource {
        root = ./.;
        fileset = lib.fileset.difference ./. ./delta.nix;
      };
    in
    {
      programs.delta.enable = true;

      programs.git.includes = [ { path = "${configDirectory}/delta.gitconfig"; } ];
    };
}
