{ inputs, ... }:
{
  flake.modules.darwin.personal = {
    imports = with inputs.self.modules.darwin; [
      system-desktop
    ];

    system.stateVersion = 7;
  };
}
