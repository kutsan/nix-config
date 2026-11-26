{ inputs, ... }:
{
  flake.modules.darwin.zed = {
    homebrew.casks = [
      "zed"
    ];

    home-manager.sharedModules = [
      inputs.self.modules.homeManager.zed
      { home.sessionVariables.GUI_EDITOR = "zed"; }
    ];
  };

  flake.modules.nixos.zed =
    { pkgs, ... }:
    {
      environment.systemPackages = [ pkgs.zed-editor ];

      home-manager.sharedModules = [
        inputs.self.modules.homeManager.zed
        { home.sessionVariables.GUI_EDITOR = "zeditor"; }
      ];
    };

  flake.modules.homeManager.zed = {
    programs.zed-editor = {
      enable = true;
      package = null;

      mutableUserSettings = false;
      mutableUserKeymaps = false;

      extensions = [
        "html"
        "git-firefly"
        "github-actions"
        "docker-compose"
      ];

      themes.poisonbloom = inputs.poisonbloom.lib.themes.zed;

      userSettings = {
        edit_predictions = {
          provider = "copilot";
        };
        use_system_prompts = false;
        tabs = {
          show_close_button = "hidden";
          show_diagnostics = "all";
          file_icons = true;
        };
        restore_on_startup = "launchpad";
        calls = {
          mute_on_join = true;
        };
        cursor_blink = false;
        terminal = {
          option_as_meta = true;
          font_fallbacks = [
            "Symbols Nerd Font Mono"
          ];
          line_height = "comfortable";
        };
        show_signature_help_after_edits = true;
        title_bar = {
          show_branch_status_icon = true;
          show_user_picture = false;
        };
        buffer_line_height = {
          custom = 1.8;
        };
        project_panel = {
          default_width = 300;
          dock = "left";
        };
        vim = {
          use_system_clipboard = "on_yank";
        };
        ui_font_family = "MonoLisaCode";
        buffer_font_family = "MonoLisaCode";
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
        auto_update = false;
        telemetry = {
          metrics = false;
          diagnostics = false;
        };
        vim_mode = true;
        icon_theme = "Symbols Icon Theme";
        buffer_font_size = 16.0;
        theme = {
          light = "Poisonbloom Light";
          dark = "Poisonbloom Dark";
        };
        agent_servers = {
          claude-acp = {
            type = "registry";
          };
        };
        agent = {
          inline_assistant_model = {
            provider = "copilot_chat";
            model = "claude-opus-4.6";
          };
          default_profile = "ask";
          default_model = {
            provider = "copilot_chat";
            model = "claude-opus-4.5";
          };
          enable_feedback = false;
        };
        profiles = {
          Focus = {
            settings = {
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
              indent_guides = {
                enabled = false;
              };
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
      };

      userKeymaps = [
        # Project Panel
        {
          context = "vim_mode == normal || ProjectPanel || EmptyPane";
          bindings = {
            "space f" = "project_panel::ToggleFocus";
          };
        }

        # Completions
        {
          context = "Editor && showing_completions";
          bindings = {
            tab = "editor::ContextMenuNext";
            shift-tab = "editor::ContextMenuPrevious";
            ctrl-e = "editor::Cancel";
          };
        }

        # Code Actions
        {
          context = "Editor && showing_code_actions";
          bindings = {
            tab = "editor::ContextMenuNext";
            shift-tab = "editor::ContextMenuPrevious";
          };
        }

        # Edit Predictions
        {
          context = "Editor && edit_prediction";
          unbind = {
            tab = "editor::AcceptEditPrediction";
            alt-tab = "editor::AcceptEditPrediction";
            alt-l = "editor::AcceptEditPrediction";
          };
          bindings = {
            ctrl-l = "editor::AcceptEditPrediction";
            ctrl-j = "editor::AcceptNextWordEditPrediction";
          };
        }

        # Pane Navigation
        {
          context = "VimControl && !menu || !Editor && !Terminal";
          bindings = {
            ctrl-h = "workspace::ActivatePaneLeft";
            ctrl-l = "workspace::ActivatePaneRight";
            ctrl-k = "workspace::ActivatePaneUp";
            ctrl-j = "workspace::ActivatePaneDown";
          };
        }

        # Save
        {
          context = "Workspace";
          bindings = {
            "\\ w" = "workspace::Save";
          };
        }

        # Format
        {
          context = "Editor";
          bindings = {
            "\\ f" = "editor::Format";
          };
        }

        # Vim Surrounds
        {
          context = "vim_mode == normal && !menu";
          bindings = {
            "s a" = "vim::PushAddSurrounds";
            "s d" = "vim::PushDeleteSurrounds";
            "s r" = "vim::PushChangeSurrounds";
            "y s" = null;
            "c s" = null;
            "d s" = null;
          };
        }
      ];
    };
  };
}
