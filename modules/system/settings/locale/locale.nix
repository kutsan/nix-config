let
  language = "en";
  region = "US";
in
{
  flake.modules.darwin.locale = {
    system.defaults = {
      NSGlobalDomain = {
        AppleMeasurementUnits = "Centimeters";
        AppleMetricUnits = 1;
        AppleTemperatureUnit = "Celsius";
        AppleICUForce24HourTime = true;
      };

      CustomUserPreferences.NSGlobalDomain = {
        AppleLanguages = [ "${language}-${region}" ];
        AppleLocale = "${language}_${region}";
        AppleFirstWeekday.gregorian = 2;
        AppleICUDateFormatStrings."1" = "y-MM-dd";
      };
    };
  };

  flake.modules.homeManager.locale = {
    home.language.base = "${language}_${region}.UTF-8";
  };
}
