{ inputs, ... }:
let
  sharedModule =
    { pkgs, ... }:
    {
      environment.systemPackages = with pkgs; [
        git
      ];

      home-manager.sharedModules = [ inputs.self.modules.homeManager.git ];
    };
in
{
  flake.modules.nixos.git = sharedModule;
  flake.modules.darwin.git = sharedModule;

  flake.modules.homeManager.git =
    { config, lib, ... }:
    {
      programs.git = {
        enable = true;
        package = null;

        settings = {
          init.defaultBranch = "main";

          core = {
            editor = "$EDITOR";
            whitespace = "space-before-tab,-indent-with-non-tab,trailing-space";
          };

          push = {
            default = "current";
            autoSetupRemote = true;
            followtags = true;
          };

          branch.sort = "-committerdate";

          tag.sort = "version:refname";

          pull.ff = "only";

          diff = {
            algorithm = "histogram";
            tool = "nvim_difftool";
            renames = "copies";
            submodule = "log";
            wsErrorHighlight = "all";
          };

          difftool.nvim_difftool.cmd = ''nvim -c "lua vim.cmd.packadd('nvim.difftool')" -d "$LOCAL" "$REMOTE"'';

          fetch = {
            prune = true;
            pruneTags = true;
            all = true;
          };

          merge = {
            tool = "nvimmerge";
            log = true;
            conflictStyle = "zdiff3";
          };

          mergetool.nvimmerge = {
            cmd = "nvim -d $LOCAL $BASE $REMOTE $MERGED -c '$wincmd w' -c 'wincmd J'";
            keepBackup = false;
            trustexitcode = true;
          };

          commit = {
            gpgsign = true;
            verbose = true;
          };

          status.branch = true;

          apply.whitespace = "error";

          grep = {
            linenumber = true;
            patterntype = "perl";
          };

          column = {
            ui = "auto";
            tag = "never";
          };

          format.pretty = "log-full";

          pretty = {
            log-default = "format:%C(auto)%h%C(reset) %C(blue)%ad%C(reset) %C(cyan)(%ar)%C(reset)%C(auto)%d%C(reset)%n %C(yellow)●%C(reset) %s %C(241)%aN <%aE>%C(reset)%n%w(0,7,7)%+(trailers:only,unfold)";
            log-full = "format:%C(auto)%h%C(reset)%C(auto)%d%C(reset)\t %C(239)[P: %p] [T: %t]%C(reset)%n%C(white)Author:%C(reset)\t\t%aN %C(241)<%aE>%C(reset)%n\t\t\t\t\t %C(blue)%ad%C(reset) %C(cyan)(%ar)%C(reset)%n%C(white)Commit:%C(reset)\t\t%cN %C(241)<%cE>%C(reset)\t\t%C(239)[GPG: %G?% GK]%C(reset)%n\t\t\t\t\t%C(blue)%cd%C(reset) %C(cyan)(%cr)%C(reset)%w(0,4,4)%n%n%C(bold)%s%C(reset)%n%n%-b%n%n%-N%n";
            reflog-default = "format:%C(auto)%h%C(reset) %C(blue)%ad%C(reset) %C(cyan)(%ar)%C(reset)%C(auto)%d%C(reset)%n %C(yellow)●%C(reset) %s %C(241)%aN <%aE>%C(reset)%n %C(yellow)○%C(reset) %C(bold yellow)(%C(magenta)%gd%C(bold yellow))%C(reset) %gs %C(241)%gN <%gE>%C(reset)%n%w(0,7,7)%+(trailers:only,unfold)";
            reflog-full = "format:%C(auto)%h%C(reset) %C(bold yellow)(%C(magenta)%gd%C(bold yellow))%C(reset)%C(auto)%d%C(reset)\t\t%C(239)[P: %p] [T: %t]%C(reset)%n%C(white)Author:%C(reset)\t %aN %C(241)<%aE>%C(reset)%n\t\t\t\t\t%C(blue)%ad%C(reset) %C(cyan)(%ar)%C(reset)%n%C(white)Commit:%C(reset)\t %cN %C(241)<%cE>%C(reset)\t %C(239)[GPG: %G?% GK]%C(reset)%n\t\t\t\t\t %C(blue)%cd%C(reset) %C(cyan)(%cr)%C(reset)%n%C(white)Reflog:%C(reset)\t\t%gN %C(241)<%gE>%C(reset)%n\t\t\t\t\t %C(auto)%gs%C(reset)%w(0,4,4)%n%n%C(bold)%s%C(reset)%n%n%-b%n%n%-N%n";
          };

          color = {
            ui = "auto";

            branch = {
              current = "yellow reverse";
              local = "yellow";
              remote = "green";
            };

            diff = {
              meta = "yellow";
              frag = "magenta";
              old = "red";
              new = "green";
              whitespace = "red reverse";
            };

            status = {
              added = "green";
              changed = "yellow";
              untracked = "red";
            };
          };

          alias = {
            a = "add";
            b = "branch";
            bl = "!git --no-pager branch --verbose --all";
            c = "commit";
            d = "diff --stat=100,100 --patch";
            ds = "d --staged";
            f = "fetch";
            t = "stash";
            tl = "!git --no-pager stash list";
            l = "log --graph --date=iso8601 --pretty=log-default";
            ld = "log --graph --date=iso8601 --pretty=log-full";
            la = "log --graph --branches --remotes --tags --date=iso8601 --pretty=log-default";
            lda = "log --graph --branches --remotes --tags --date=iso8601 --pretty=log-full";
            prune-merged = "!git branch --merged | grep --invert-match --extended-regexp '^[*+]| (main|master)$' | xargs --no-run-if-empty --max-args=1 git branch --delete";
            r = "reflog --date=iso8601 --pretty=reflog-default";
            rd = "reflog --date=iso8601 --pretty=reflog-full";
            s = "status --short";
            sm = "submodule";
            sw = "switch";
            fixup = "!git log -n 50 --pretty=format:'%h %s' --no-merges | fzf | cut -c -7 | xargs -o git commit --fixup";
            recent = "!git standup -d 3 -sgc";
          };
        };

        ignores = [
          "# Operating System Files"
          ".DS_Store"
        ];

        # Machine-specific settings that stay out of the repository.
        includes = lib.mkAfter [ { path = "${config.xdg.configHome}/git/local.gitconfig"; } ];
      };
    };
}
