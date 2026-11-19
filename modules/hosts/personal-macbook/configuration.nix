{ inputs, ... }:
{
  flake.modules.darwin.personal-macbook = {
    imports = with inputs.self.modules.darwin; [
      system-desktop
      personal
    ];

    system.stateVersion = 7;
  };
}
