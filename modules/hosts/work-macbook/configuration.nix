{ inputs, ... }:
{
  flake.modules.darwin.work-macbook = {
    imports = with inputs.self.modules.darwin; [
      system-desktop
      work
    ];

    system.stateVersion = 7;
  };
}
