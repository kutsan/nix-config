{ inputs, ... }:
{
  flake.modules.darwin.ghostty = {
    homebrew.casks = [
      "ghostty"
    ];

    home-manager.sharedModules = [ inputs.self.modules.homeManager.ghostty ];
  };

  flake.modules.homeManager.ghostty = {
    programs.ghostty = {
      enable = true;
      package = null;
      enableZshIntegration = false;

      settings = {
        # Font families
        font-family = "MonoLisaCode";
        font-family-bold = "MonoLisaCode";
        font-family-italic = "MonoLisaCode";
        font-family-bold-italic = "MonoLisaCode";
        window-title-font-family = "MonoLisaCode";

        # Font size in points
        font-size = 17;

        # Font features
        font-feature = [
          "cv01"
          "cv02"
          "cv03"
          "cv04"
          "cv05"
          "cv08"
          "cv09"
          "cv10"
          "cv11"
          "cv12"
          "dlig"
          "ss04"
          "ss13"
          "zero"
        ];

        # Modify font characteristics
        adjust-underline-position = "25%";
        adjust-cell-height = "35%";
        cursor-style-blink = false;
        window-padding-x = 0;
        window-padding-y = 0;
        window-padding-balance = true;

        # Cursor
        adjust-cursor-height = 17;
        adjust-cursor-thickness = 5;

        # Colors
        theme = "dark:Poisonbloom Dark.conf,light:Poisonbloom Light.conf";
        window-colorspace = "display-p3";
        window-padding-color = "extend-always";

        # Integration
        shell-integration-features = "no-cursor,sudo,no-title";
        mouse-hide-while-typing = true;
        macos-option-as-alt = "left";

        # Quick terminal
        quick-terminal-position = "center";
        quick-terminal-size = "70%,90%";
        quick-terminal-animation-duration = 0;

        # macOS settings
        macos-titlebar-style = "hidden";

        # Notifications
        notify-on-command-finish = "unfocused";
        notify-on-command-finish-action = "no-bell,notify";
        notify-on-command-finish-after = "10s";

        keybind = [
          # Common keybindings
          "performable:super+c=copy_to_clipboard"
          "super+shift+;=toggle_command_palette"

          # Prompt navigation keybindings
          "super+shift+arrow_up=jump_to_prompt:-1"
          "super+shift+arrow_down=jump_to_prompt:1"

          # Split navigation keybindings
          "super+z=toggle_split_zoom"
          "super+h=goto_split:left"
          "super+j=goto_split:bottom"
          "super+k=goto_split:top"
          "super+l=goto_split:right"

          # Split management keybindings
          "super+d=ignore"
          "super+d>j=new_split:down"
          "super+d>k=new_split:up"
          "super+d>h=new_split:left"
          "super+d>l=new_split:right"

          # Resize splits keybindings
          "resize/k=resize_split:up,30"
          "resize/j=resize_split:down,30"
          "resize/h=resize_split:left,30"
          "resize/l=resize_split:right,30"
          "resize/shift+k=resize_split:up,100"
          "resize/shift+j=resize_split:down,100"
          "resize/shift+h=resize_split:left,100"
          "resize/shift+l=resize_split:right,100"
          "resize/arrow_up=resize_split:up,10"
          "resize/arrow_down=resize_split:down,10"
          "resize/arrow_left=resize_split:left,10"
          "resize/arrow_right=resize_split:right,10"
          "resize/escape=deactivate_key_table"
          "resize/catch_all=ignore"
          "super+r=activate_key_table:resize"

          # Disable default keybindings
          "super+shift+d=ignore"
          "super+arrow_up=ignore"
          "super+arrow_down=ignore"
          "super+alt+shift+w=ignore"
          "super+alt+shift+j=ignore"
          "super+shift+p=unbind"
          "super+[=unbind"
          "super+]=unbind"
        ];
      };
    };

    xdg.configFile."ghostty/themes".source = inputs.poisonbloom.lib.themes.ghostty;
  };
}
