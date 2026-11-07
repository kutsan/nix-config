{
  flake.modules.homeManager.wallpapers =
    { lib, pkgs, ... }:
    {
      home.activation.wallpapers = lib.hm.dag.entryAfter [ "writeBoundary" ] ''
        run mkdir -p "$HOME/Pictures/Wallpapers"
        run ${lib.getExe pkgs.rsync} $VERBOSE_ARG --archive --delete --chmod=u+w \
          ${pkgs.local.kutsan-wallpapers}/share/wallpapers/ "$HOME/Pictures/Wallpapers/"
      '';
    };
}
