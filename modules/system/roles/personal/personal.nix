{ inputs, ... }:
let
  sharedModule = {
    home-manager.sharedModules = [ inputs.self.modules.homeManager.personal ];
  };
in
{
  flake.modules.nixos.personal = sharedModule;

  flake.modules.darwin.personal = {
    imports = [
      sharedModule
    ]
    ++ (with inputs.self.modules.darwin; [
      audacity
      backblaze
      blender
      discord
      handbrake
      hyperduck
      ledger-wallet
      netnewswire
      obs
      orcaslicer
      parachute-backup
      transmission
    ]);
  };

  flake.modules.homeManager.personal = { };
}
