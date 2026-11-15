let
  sharedModule = {
    programs.direnv.enable = true;
  };
in
{
  flake.modules.nixos.direnv = sharedModule;
  flake.modules.darwin.direnv = sharedModule;
}
