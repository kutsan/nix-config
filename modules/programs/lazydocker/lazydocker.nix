{
  flake.modules.homeManager.lazydocker = {
    programs.lazydocker = {
      enable = true;

      settings = {
        gui = {
          theme = {
            activeBorderColor = [ "blue" ];
            inactiveBorderColor = [ "black" ];
            selectedLineBgColor = [ "black" ];
            optionsTextColor = [ "black" ];
          };
          returnImmediately = true;
          showBottomLine = false;
          expandFocusedSidePanel = true;
          containerStatusHealthStyle = "icon";
        };
      };
    };
  };
}
