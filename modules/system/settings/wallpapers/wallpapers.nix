let
  wallpaperFolderPath = "Pictures/Wallpapers";
in
{
  flake.modules.darwin.wallpapers = {
    home-manager.sharedModules = [
      {
        manualSetup.wallpapers = [
          "In **System Settings > Wallpaper**, add the folder `~/${wallpaperFolderPath}`, pick a wallpaper from it and turn on **Show on all Spaces**."
        ];
      }
    ];
  };

  flake.modules.homeManager.wallpapers =
    { pkgs, ... }:
    {
      home.file.${wallpaperFolderPath}.source = "${pkgs.local.kutsan-wallpapers}/share/wallpapers";
    };
}
