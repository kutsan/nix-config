{
  flake.modules.homeManager.fzf =
    { lib, ... }:
    let
      colors = {
        fg = -1;
        bg = -1;
        hl = 4;
        "fg+" = 7;
        "bg+" = 0;
        gutter = 0;
        "hl+" = 4;
        info = 8;
        border = 8;
        prompt = 4;
        pointer = 3;
        marker = 3;
        spinner = 8;
        header = 6;
      };

      colorOption =
        "--color=dark,"
        + lib.concatStringsSep "," (lib.mapAttrsToList (name: value: "${name}:${toString value}") colors);
    in
    {
      programs.fzf = {
        enable = true;

        defaultCommand = "fd --no-ignore";
        defaultOptions = [
          colorOption
          "--no-multi"
          "--no-mouse"
          "--height=40%"
          "--margin=1,3"
          "--layout=reverse"
          "--info=inline"
          "--no-separator"
          "--no-bold"
          "--bind=ctrl-f:half-page-down"
          "--bind=ctrl-b:half-page-up"
        ];
      };

      home.sessionVariables.FZF_DEFAULT_COLORS = colorOption;
    };
}
