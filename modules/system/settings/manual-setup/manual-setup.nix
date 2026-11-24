{
  flake.modules.homeManager.manual-setup =
    { config, lib, ... }:
    let
      readDirectoryTree =
        path:
        let
          name = baseNameOf path;
        in
        {
          inherit name;
          isFeature = builtins.pathExists (path + "/${name}.nix");
          subdirectories = lib.pipe (builtins.readDir path) [
            (lib.filterAttrs (_: type: type == "directory"))
            lib.attrNames
            (map (subdirectoryName: readDirectoryTree (path + "/${subdirectoryName}")))
          ];
        };

      flattenDirectoryTree =
        directory: [ directory ] ++ lib.concatMap flattenDirectoryTree directory.subdirectories;

      modulesDirectoryTree = readDirectoryTree ../../..;

      featureNames = lib.pipe modulesDirectoryTree [
        flattenDirectoryTree
        (lib.filter (directory: directory.isFeature))
        (map (directory: directory.name))
      ];

      tasksOf =
        directory: lib.optionals directory.isFeature (config.manualSetup.${directory.name} or [ ]);

      renderHeading = headingLevel: name: "\n${lib.strings.replicate headingLevel "#"} `${name}`\n";

      renderTask = task: "- [ ] ${task}\n";

      renderTasks =
        tasks: lib.optionalString (tasks != [ ]) ("\n" + lib.concatMapStrings renderTask tasks);

      renderDirectory =
        { headingLevel, directory }:
        let
          body =
            renderTasks (tasksOf directory)
            + renderSubdirectories {
              headingLevel = headingLevel + 1;
              inherit directory;
            };
        in
        lib.optionalString (body != "") (renderHeading headingLevel directory.name + body);

      renderSubdirectories =
        { headingLevel, directory }:
        lib.concatMapStrings (
          subdirectory:
          renderDirectory {
            inherit headingLevel;
            directory = subdirectory;
          }
        ) directory.subdirectories;
    in
    {
      options.manualSetup = lib.mkOption {
        type = lib.types.attrsOf (lib.types.listOf lib.types.str);
        default = { };
      };

      config = lib.mkIf (config.manualSetup != { }) {
        assertions = map (feature: {
          assertion = lib.elem feature featureNames;
          message = "`manualSetup.${feature}` has no matching `modules/**/${feature}/${feature}.nix`";
        }) (lib.attrNames config.manualSetup);

        xdg.dataFile."doc/manual-setup/manual-setup.md".text =
          "# Manual Setup\n\nWhat Nix can't set up on this machine, in any order.\n"
          + renderSubdirectories {
            headingLevel = 2;
            directory = modulesDirectoryTree;
          };
      };
    };
}
