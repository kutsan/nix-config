{ inputs, ... }:
let
  # Installs the Home Manager build system-wide too, so `sudo nvim` finds it however sudo sets PATH.
  sharedModule =
    { config, ... }:
    {
      environment.systemPackages = [
        config.home-manager.users.${config.systemConstants.username}.programs.neovim.finalPackage
      ];

      home-manager.sharedModules = [ inputs.self.modules.homeManager.neovim ];
    };
in
{
  flake.modules.nixos.neovim = sharedModule;
  flake.modules.darwin.neovim = sharedModule;

  flake.modules.homeManager.neovim =
    { lib, pkgs, ... }:
    {
      programs.neovim = {
        enable = true;
        defaultEditor = true;

        withNodeJs = false;
        withPerl = false;
        withPython3 = false;
        withRuby = false;

        # Loads Home Manager's own init code through the wrapper, since `init.lua` comes from the
        # config folder below.
        sideloadInitLua = true;

        plugins = with pkgs.vimPlugins; [
          # Colorschemes
          # Pinned to the commit the colorscheme was made with, since the older one in nixpkgs themes
          # more plugins and changes their colors. Drop the pin once nixpkgs reaches it.
          (catppuccin-nvim.overrideAttrs {
            version = "2.0.0-unstable-2026-08-09";
            src = pkgs.fetchFromGitHub {
              owner = "catppuccin";
              repo = "nvim";
              rev = "edefef779ab08ce1a4a404713e3012b0d202bd35";
              hash = "sha256-EVTNyE0tkPAAgp55sHjxEGtY25sSqSs9nmI4liPJxm4=";
            };
          })

          # Treesitter
          (nvim-treesitter.withPlugins (
            parsers: with parsers; [
              arduino
              astro
              awk
              bash
              c
              comment
              cpp
              css
              csv
              diff
              dockerfile
              editorconfig
              git_config
              git_rebase
              gitattributes
              gitcommit
              gitignore
              gnuplot
              gpg
              graphql
              html
              http
              javascript
              jq
              jsdoc
              json
              json5
              ledger
              lua
              luadoc
              luap
              make
              markdown
              markdown_inline
              mermaid
              nix
              printf
              prisma
              query
              regex
              rust
              sql
              ssh_config
              toml
              tsx
              typescript
              typst
              vim
              vimdoc
              xml
              yaml
            ]
          ))
          nvim-treesitter-context
          nvim-treesitter-textobjects
          nvim-ts-autotag

          # Completion & Tooling
          blink-cmp
          conform-nvim
          lazydev-nvim
          nvim-lspconfig
          pkgs.local.nvim-ts-error-translator
          SchemaStore-nvim

          # Git
          codediff-nvim
          gitsigns-nvim

          # Navigation & Buffers
          bufferline-nvim
          flash-nvim
          pkgs.local.nvim-windovigation
          scope-nvim

          # Search & Replace
          grug-far-nvim

          # Editing & Text Objects
          mini-pairs
          mini-surround

          # Visual
          mini-icons
          mini-indentscope
          nvim-highlight-colors
          pkgs.local.nvim-color-converter
          render-markdown-nvim
          snacks-nvim
          tiny-cmdline-nvim

          # Utilities
          nvim-early-retirement
          qmk-nvim
        ];

        extraPackages = with pkgs; [
          # JavaScript, TypeScript, CSS, HTML, JSON
          local.cssmodules-language-server
          local.stylelint-language-server
          oxfmt
          oxlint
          prettierd
          typescript-language-server
          vscode-langservers-extracted

          # Shell
          bash-language-server
          shellcheck
          shfmt

          # Lua
          lua-language-server
          selene
          stylua

          # Python
          ruff
          ty

          # YAML
          yaml-language-server

          # TOML
          tombi

          # Markdown
          markdown-oxide
          rumdl

          # Typst
          tinymist
          typstyle

          # Docker
          docker-compose-language-service
          docker-language-server

          # Terraform
          terraform-ls

          # GitHub Actions
          local.gh-actions-language-server

          # Vim Script
          vim-language-server

          # Nix
          nixd
          nixfmt

          # Prose
          harper
          typos
          typos-lsp

          # AI
          copilot-language-server
        ];
      };

      home.sessionVariables.MANPAGER = "nvim +Man!";

      xdg.configFile.nvim.source = lib.fileset.toSource {
        root = ./config;
        fileset = lib.fileset.fileFilter (file: !lib.hasPrefix "." file.name) ./config;
      };
    };
}
