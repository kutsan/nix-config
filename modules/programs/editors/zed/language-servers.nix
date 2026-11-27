{
  flake.modules.homeManager.zed =
    { lib, pkgs, ... }:
    let
      javascriptLanguageServers = [
        "typescript-ls"
        "!vtsls"
        "!typescript-language-server"
        "!tailwindcss-language-server"
        "..."
      ];
    in
    {
      programs.zed-editor.userSettings = {
        node.path = lib.getExe pkgs.nodejs;

        languages = {
          JavaScript.language_servers = javascriptLanguageServers;
          TypeScript.language_servers = javascriptLanguageServers;
          TSX.language_servers = javascriptLanguageServers;
          CSS.language_servers = [
            "!tailwindcss-language-server"
            "..."
          ];
          HTML.language_servers = [
            "!tailwindcss-language-server"
            "..."
          ];
          Dockerfile.language_servers = [
            "!dockerfile-language-server"
            "..."
          ];
          Python.language_servers = [
            "ty"
            "ruff"
            "!basedpyright"
            "!pyrefly"
            "!pyright"
            "!pylsp"
            "..."
          ];
          Nix.language_servers = [
            "nixd"
            "!nil"
            "..."
          ];
        };

        lsp = {
          # JavaScript, TypeScript, CSS, HTML, JSON
          typescript-ls.binary = {
            path = lib.getExe pkgs.typescript;
            arguments = [
              "--lsp"
              "--stdio"
            ];
          };
          eslint.binary = {
            path = lib.getExe' pkgs.vscode-langservers-extracted "vscode-eslint-language-server";
            arguments = [ "--stdio" ];
          };
          vscode-html-language-server.binary = {
            path = lib.getExe' pkgs.vscode-langservers-extracted "vscode-html-language-server";
            arguments = [ "--stdio" ];
          };
          vscode-css-language-server.binary = {
            path = lib.getExe' pkgs.vscode-langservers-extracted "vscode-css-language-server";
            arguments = [ "--stdio" ];
          };
          stylelint-lsp.binary = {
            path = lib.getExe pkgs.local.stylelint-language-server;
            arguments = [ "--stdio" ];
          };
          json-language-server.binary = {
            path = lib.getExe' pkgs.vscode-langservers-extracted "vscode-json-language-server";
            arguments = [ "--stdio" ];
          };
          package-version-server.binary.path = lib.getExe pkgs.package-version-server;

          # Shell
          bash-language-server.binary = {
            path = lib.getExe pkgs.bash-language-server;
            arguments = [ "start" ];
          };

          # Lua
          lua-language-server.binary.path = lib.getExe pkgs.lua-language-server;

          # Python
          ty.binary = {
            path = lib.getExe pkgs.ty;
            arguments = [ "server" ];
          };
          ruff.binary = {
            path = lib.getExe pkgs.ruff;
            arguments = [ "server" ];
          };

          # C, C++
          clangd.binary.path = lib.getExe' pkgs.llvmPackages_latest.clang-tools "clangd";

          # Go
          gopls.binary = {
            path = lib.getExe pkgs.gopls;
            arguments = [ "-mode=stdio" ];
          };

          # Rust
          rust-analyzer.binary.path = lib.getExe pkgs.rust-analyzer;

          # YAML
          yaml-language-server.binary = {
            path = lib.getExe pkgs.yaml-language-server;
            arguments = [ "--stdio" ];
          };

          # TOML
          tombi.binary = {
            path = lib.getExe pkgs.tombi;
            arguments = [ "lsp" ];
          };

          # Markdown
          markdown-oxide.binary.path = lib.getExe pkgs.markdown-oxide;
          rumdl.binary = {
            path = lib.getExe pkgs.rumdl;
            arguments = [ "server" ];
          };

          # Typst
          tinymist.binary = {
            path = lib.getExe pkgs.tinymist;
            arguments = [ "lsp" ];
          };

          # Docker
          docker-language-server.binary = {
            path = lib.getExe pkgs.docker-language-server;
            arguments = [
              "start"
              "--stdio"
            ];
          };

          # Terraform
          terraform-ls.binary = {
            path = lib.getExe pkgs.terraform-ls;
            arguments = [ "serve" ];
          };

          # GitHub Actions
          gh-actions-language-server.binary = {
            path = lib.getExe pkgs.local.gh-actions-language-server;
            arguments = [ "--stdio" ];
          };

          # Nix
          nixd.binary.path = lib.getExe pkgs.nixd;

          # Prose
          typos = {
            binary.path = lib.getExe pkgs.typos-lsp;
            initialization_options.diagnosticSeverity = "Hint";
          };
          harper-ls.binary = {
            path = lib.getExe pkgs.harper;
            arguments = [ "--stdio" ];
          };
        };
      };
    };
}
