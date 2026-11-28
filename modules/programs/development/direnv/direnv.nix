let
  sharedModule = {
    programs.direnv = {
      enable = true;
      silent = true;
    };
  };
in
{
  flake.modules.nixos.direnv = sharedModule;
  flake.modules.darwin.direnv = sharedModule;
}
