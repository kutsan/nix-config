{
  flake.modules.homeManager.sbx =
    { lib, pkgs, ... }:
    let
      inherit (pkgs.local.kutsan-skills) src;

      source = fetchTree {
        type = "github";
        inherit (src) owner repo rev;
        narHash = src.outputHash;
      };

      skillsDirectory = "${source}/skills";
      bundledSkillsDirectory = "/usr/share/agent-skills";
    in
    {
      sbx.kits.agent-skills = {
        descriptor = {
          displayName = "Agent skills";
          description = "Personal skills for the coding agent, whichever agent the sandbox runs";

          build = ''
            FROM scratch
            COPY skills/ ${bundledSkillsDirectory}/
          '';

          capabilities =
            map
              (skill: {
                type = "com.docker.sandbox/agent-skill@1";
                config.path = "${bundledSkillsDirectory}/${skill}";
              })
              (lib.attrNames (lib.filterAttrs (_: type: type == "directory") (builtins.readDir skillsDirectory)));
        };

        files.skills = skillsDirectory;
      };
    };
}
