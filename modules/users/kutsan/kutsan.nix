{ inputs, ... }:
let
  username = "kutsan";

  sharedModule = {
    home-manager.users.${username}.imports = [ inputs.self.modules.homeManager.${username} ];
  };
in
{
  flake.modules.nixos.${username} =
    { pkgs, ... }:
    {
      imports = [ sharedModule ];

      users.users.${username} = {
        isNormalUser = true;
        extraGroups = [ "wheel" ];
        shell = pkgs.zsh;
      };
    };

  flake.modules.darwin.${username} =
    let
      loginShell = "/run/current-system/sw/bin/zsh";
    in
    {
      imports = [ sharedModule ];

      users.users.${username}.home = "/Users/${username}";

      system.primaryUser = username;

      system.activationScripts.postActivation.text = ''
        if [[ "$(/usr/bin/dscl . -read /Users/${username} UserShell)" != "UserShell: ${loginShell}" ]]; then
          echo "setting the login shell of ${username} to ${loginShell}..." >&2
          /usr/bin/dscl . -create /Users/${username} UserShell ${loginShell}
        fi
      '';
    };

  flake.modules.homeManager.${username} =
    { config, ... }:
    {
      programs.git.settings.user = {
        name = "Kutsan Kaplan";
        email = "me@kutsan.dev";
        signingkey = "24D78A1B";
      };

      sops = {
        defaultSopsFile = ./secrets.yaml;
        secrets.atuin-key = { };
      };

      programs.atuin.settings.key_path = config.sops.secrets.atuin-key.path;

      home.file."Documents/Projects/.keep".text = "";
    };
}
