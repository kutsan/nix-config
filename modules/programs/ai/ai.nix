{
  flake.modules.homeManager.ai =
    { lib, pkgs, ... }:
    {
      home.file.".agents/AGENTS.md".source = ./AGENTS.md;

      home.activation.skills = lib.hm.dag.entryAfter [ "writeBoundary" ] ''
        run mkdir -p "$HOME/.agents/skills"
        run ${lib.getExe pkgs.rsync} $VERBOSE_ARG --archive --delete --chmod=u+w \
          ${pkgs.local.kutsan-skills}/share/skills/ "$HOME/.agents/skills/"
      '';
    };
}
