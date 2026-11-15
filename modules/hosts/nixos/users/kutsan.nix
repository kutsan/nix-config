{ inputs, ... }:
{
  flake.modules.nixos.nixos = {
    imports = with inputs.self.modules.nixos; [
      kutsan
    ];
  };
}
