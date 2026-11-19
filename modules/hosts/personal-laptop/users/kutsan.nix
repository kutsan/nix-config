{ inputs, ... }:
{
  flake.modules.nixos.personal-laptop = {
    imports = with inputs.self.modules.nixos; [
      kutsan
    ];

    systemConstants.username = "kutsan";
  };
}
