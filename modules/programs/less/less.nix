{
  flake.modules.homeManager.less = {
    programs.less = {
      enable = true;

      config = ''
        #command
        h left-scroll
        l right-scroll
      '';
    };
  };
}
