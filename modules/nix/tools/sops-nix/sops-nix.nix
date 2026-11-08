{ inputs, ... }:
{
  flake.modules.homeManager.sops-nix =
    { config, ... }:
    {
      imports = [ inputs.sops-nix.homeManagerModules.sops ];

      sops.age.keyFile = "${config.xdg.configHome}/sops/age/keys.txt";
    };
}
