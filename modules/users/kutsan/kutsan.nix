{ inputs, ... }:
let
  sharedModule =
    { config, ... }:
    {
      home-manager.users.${config.systemConstants.username}.imports = [
        inputs.self.modules.homeManager.kutsan
      ];
    };
in
{
  flake.modules.nixos.kutsan =
    { config, pkgs, ... }:
    let
      username = config.systemConstants.username;
    in
    {
      imports = [ sharedModule ];

      users.users.${username} = {
        isNormalUser = true;
        extraGroups = [ "wheel" ];
        shell = pkgs.zsh;
      };
    };

  flake.modules.darwin.kutsan =
    { config, lib, ... }:
    let
      username = config.systemConstants.username;
      userRecordPath = "/Users/${username}";
      loginShell = "/run/current-system/sw/bin/zsh";
    in
    {
      imports = [ sharedModule ];

      users.users.${username}.home = "/Users/${username}";

      system.primaryUser = username;

      system.activationScripts.postActivation.text = ''
        if [[ "$(/usr/bin/dscl . -read ${lib.escapeShellArg userRecordPath} UserShell)" != ${lib.escapeShellArg "UserShell: ${loginShell}"} ]]; then
          printf '%s\n' ${lib.escapeShellArg "setting the login shell of ${username} to ${loginShell}..."} >&2
          /usr/bin/dscl . -create ${lib.escapeShellArg userRecordPath} UserShell ${lib.escapeShellArg loginShell}
        fi
      '';
    };

  flake.modules.homeManager.kutsan =
    { config, ... }:
    {
      identity = {
        fullName = "Kutsan Kaplan";
        email = "me@kutsan.dev";
        website = "https://kutsan.dev";
        signingKey = "24D78A1B";
      };

      sops = {
        defaultSopsFile = ./secrets.yaml;
        secrets.atuin-key = { };
      };

      programs.atuin.settings.key_path = config.sops.secrets.atuin-key.path;

      home.file."Documents/Projects/.keep".text = "";
    };
}
