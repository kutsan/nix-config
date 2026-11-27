{
  flake.modules.homeManager.zed = {
    programs.zed-editor.userSettings = {
      # Updates
      auto_update = false;

      # Privacy
      telemetry = {
        diagnostics = false;
        metrics = false;
      };

      # Startup
      restore_on_startup = "launchpad";

      # Theme
      theme = {
        light = "Poisonbloom Light";
        dark = "Poisonbloom Dark";
      };
      icon_theme = "Symbols Icon Theme";

      # Fonts
      ui_font_family = "MonoLisaCode";
      buffer_font_family = "MonoLisaCode";
      buffer_font_size = 16.0;
      buffer_line_height.custom = 1.8;
      buffer_font_features = {
        cv01 = true;
        cv02 = true;
        cv03 = true;
        cv04 = true;
        cv05 = true;
        cv08 = true;
        cv09 = true;
        cv10 = true;
        cv11 = true;
        cv12 = true;
        dlig = true;
        ss04 = true;
        ss13 = true;
        zero = true;
      };
      markdown_preview.font_family = "MonoLisaText";

      # Interface
      title_bar = {
        show = "never";
        show_user_picture = false;
        show_branch_status_icon = true;
      };
      tab_bar = {
        show_nav_history_buttons = false;
        show_tab_bar_buttons = false;
      };
      tabs = {
        file_icons = true;
        show_close_button = "hidden";
        show_diagnostics = "all";
      };
      status_bar.cursor_position_button = false;
      search.button = false;
      use_system_prompts = false;

      # Panels
      project_panel = {
        dock = "left";
        default_width = 300;
      };
      outline_panel.dock = "left";
      git_panel.dock = "left";
      collaboration_panel = {
        dock = "left";
        button = false;
      };

      # Editor
      cursor_blink = false;
      current_line_highlight = "line";
      format_on_save = "on";
      formatter = "language_server";
      auto_signature_help = true;
      show_signature_help_after_edits = true;
      modeline_lines = 0;

      # Vim
      vim_mode = true;
      vim = {
        use_system_clipboard = "never";
        highlight_on_yank_duration = 100;
      };

      # Terminal
      terminal = {
        button = false;
        font_fallbacks = [ "Symbols Nerd Font Mono" ];
        line_height = "comfortable";
        option_as_meta = true;
      };

      # AI
      edit_predictions = {
        provider = "copilot";
        allow_data_collection = "no";
      };
      agent = {
        dock = "right";
        play_sound_when_agent_done = "always";
        enable_feedback = false;
      };

      # Profiles
      profiles.Focus.settings = {
        buffer_font_size = 18;
        tab_bar = {
          show = false;
          show_nav_history_buttons = false;
        };
        toolbar = {
          breadcrumbs = false;
          quick_actions = false;
        };
        gutter = {
          line_numbers = false;
          folds = false;
          breakpoints = false;
          runnables = false;
          min_line_number_digits = 0;
        };
        indent_guides.enabled = false;
        scrollbar = {
          show = "never";
          cursors = false;
          diagnostics = "none";
          search_results = false;
          selected_symbol = false;
        };
      };
    };
  };
}
