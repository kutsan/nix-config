{ inputs, ... }:
{
  flake.modules.homeManager.bat =
    { lib, ... }:
    {
      programs.bat = {
        enable = true;

        config = {
          theme-light = "Poisonbloom Light";
          theme-dark = "Poisonbloom Dark";
        };

        themes = lib.genAttrs [ "Poisonbloom Dark" "Poisonbloom Light" ] (name: {
          src = inputs.poisonbloom.lib.themes.bat;
          file = "${name}.tmTheme";
        });
      };
    };
}
