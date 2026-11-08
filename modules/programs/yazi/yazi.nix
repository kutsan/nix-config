{
  flake.modules.homeManager.yazi =
    { pkgs, ... }:
    let
      bind = on: run: { inherit on run; };

      mkFlavor =
        name: batTheme:
        pkgs.linkFarm "${name}.yazi" {
          "flavor.toml" = ./flavors + "/${name}/flavor.toml";
          "tmtheme.xml" = "${../bat/themes}/${batTheme}.tmTheme";
        };
    in
    {
      programs.yazi = {
        enable = true;
        enableZshIntegration = false;

        settings = {
          mgr = {
            show_hidden = true;
            ratio = [
              1
              1
              1
            ];
            title_format = "{cwd}: yazi";
            linemode = "size";
          };
          plugin = {
            prepend_fetchers = [
              {
                group = "git";
                url = "*";
                run = "git";
              }
              {
                group = "git";
                url = "*/";
                run = "git";
              }
            ];
          };
        };

        theme = {
          flavor = {
            dark = "poisonbloom-dark";
            light = "poisonbloom-light";
          };
          mgr = {
            border_symbol = " ";
          };
        };

        keymap.mgr.keymap = [
          # Quit
          (bind "<Esc>" "escape")
          (bind "<C-[>" "escape")
          (bind "q" "quit")
          (bind "Q" "quit --no-cwd-file")
          (bind "<C-c>" "close")
          (bind "<C-z>" "suspend")

          # Hopping
          (bind "k" "arrow prev")
          (bind "j" "arrow next")
          (bind "<Up>" "arrow prev")
          (bind "<Down>" "arrow next")
          (bind "<C-u>" "arrow -50%")
          (bind "<C-d>" "arrow 50%")
          (bind "<S-PageUp>" "arrow -50%")
          (bind "<S-PageDown>" "arrow 50%")
          (bind [ "g" "g" ] "arrow top")
          (bind "G" "arrow bot")

          # Navigation
          (bind "h" "leave")
          (bind "l" "enter")
          (bind "<Left>" "leave")
          (bind "<Right>" "enter")
          (bind "<C-o>" "back")
          (bind "<C-i>" "forward")

          # Toggle
          (bind "<Space>" [
            "toggle"
            "arrow next"
          ])
          (bind "<C-a>" "toggle_all --state=on")
          (bind "<C-r>" "toggle_all")

          # Visual mode
          (bind "v" "visual_mode")
          (bind "V" "visual_mode --unset")

          # Spotting
          (bind "i" "spot")

          # Operations
          (bind "o" "open --interactive")
          (bind "<Enter>" "open")
          (bind "<S-Enter>" "shell --block '$EDITOR .'")
          (bind "y" "yank")
          (bind "p" "paste")
          (bind "P" "paste --force")
          (bind "u" "unyank")
          (bind "d" "yank --cut")
          (bind "D" "remove")
          (bind "c" "create")
          (bind "r" "rename --cursor=before_ext")
          (bind "$" "shell --block --interactive")
          (bind "<C-f>" "search --via=fd")
          (bind "<C-p>" "plugin fzf")
          (bind [ "g" "s" ] "search --via=rg")

          # Linemode
          (bind [ "m" "s" ] "linemode size")
          (bind [ "m" "p" ] "linemode permissions")
          (bind [ "m" "b" ] "linemode btime")
          (bind [ "m" "m" ] "linemode mtime")
          (bind [ "m" "o" ] "linemode owner")
          (bind [ "m" "n" ] "linemode none")

          # Copy
          (bind [ "g" "y" "p" ] "copy path")
          (bind [ "g" "y" "d" ] "copy dirname")
          (bind [ "g" "y" "n" ] "copy filename")
          (bind [ "g" "y" "N" ] "copy name_without_ext")

          # Filter
          (bind "f" "filter --smart")

          # Find
          (bind "/" "find --smart")
          (bind "?" "find --previous --smart")
          (bind "n" "find_arrow")
          (bind "N" "find_arrow --previous")

          # Sorting
          (bind [ "s" "m" ] [ "sort mtime --reverse=no" "linemode mtime" ])
          (bind [ "s" "M" ] [ "sort mtime --reverse" "linemode mtime" ])
          (bind [ "s" "b" ] [ "sort btime --reverse=no" "linemode btime" ])
          (bind [ "s" "B" ] [ "sort btime --reverse" "linemode btime" ])
          (bind [ "s" "e" ] "sort extension --reverse=no")
          (bind [ "s" "E" ] "sort extension --reverse")
          (bind [ "s" "a" ] "sort alphabetical --reverse=no")
          (bind [ "s" "A" ] "sort alphabetical --reverse")
          (bind [ "s" "n" ] "sort natural --reverse=no")
          (bind [ "s" "N" ] "sort natural --reverse")
          (bind [ "s" "s" ] [ "sort size --reverse=no" "linemode size" ])
          (bind [ "s" "S" ] [ "sort size --reverse" "linemode size" ])
          (bind [ "s" "r" ] "sort random --reverse=no")

          # Goto
          (bind [ "g" "<Space>" ] "cd --interactive")
          (bind [ "g" "f" ] "follow")

          # Bookmarks
          (bind [ "b" "h" ] "cd ~")
          (bind [ "b" "w" ] "cd ~/Downloads")
          (bind [ "b" "d" ] "cd ~/Documents")
          (bind [ "b" "p" ] "cd ~/Documents/Projects")
          (bind [ "b" "x" "c" ] "cd $XDG_CONFIG_HOME")
          (bind [ "b" "x" "a" ] "cd $XDG_CACHE_HOME")
          (bind [ "b" "x" "d" ] "cd $XDG_DATA_HOME")
          (bind [ "b" "x" "s" ] "cd $XDG_STATE_HOME")
          (bind [ "b" "i" ] "cd ~/Library/Mobile\\ Documents/com~apple~CloudDocs")
          (bind [ "b" "c" ] "cd /etc/nix-darwin")

          # Tabs
          (bind "t" "tab_create --current")
          (bind "1" "tab_switch 0")
          (bind "2" "tab_switch 1")
          (bind "3" "tab_switch 2")
          (bind "4" "tab_switch 3")
          (bind "5" "tab_switch 4")
          (bind "6" "tab_switch 5")
          (bind "7" "tab_switch 6")
          (bind "8" "tab_switch 7")
          (bind "9" "tab_switch 8")
          (bind "[" "tab_switch -1 --relative")
          (bind "]" "tab_switch 1 --relative")
          (bind "{" "tab_swap -1")
          (bind "}" "tab_swap 1")

          # Tasks
          (bind "w" "tasks:show")

          # Layout
          (bind [ "z" "z" ] "plugin change-ratio -- 1 1 1") # Default columns
          (bind [ "z" "s" ] "plugin change-ratio -- 0 1 0") # Single column
          (bind [ "z" "f" ] "plugin change-ratio -- 1 3 1") # Focused column
          (bind [ "z" "p" ] "plugin change-ratio -- 0 1 3") # Preview column

          # Help
          (bind "~" "help")
          (bind "<F1>" "help")

          # Zoxide
          (bind "<C-k>" "plugin zoxide")
        ];

        initLua = ./init.lua;

        plugins = {
          git = pkgs.yaziPlugins.git;
          change-ratio = ./plugins/change-ratio;
          folder-rules = ./plugins/folder-rules;
        };

        flavors = {
          poisonbloom-dark = mkFlavor "poisonbloom-dark" "Poisonbloom Dark";
          poisonbloom-light = mkFlavor "poisonbloom-light" "Poisonbloom Light";
        };
      };
    };
}
