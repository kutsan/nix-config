{ inputs, ... }:
{
  flake.modules.darwin.personal-macbook = {
    imports = with inputs.self.modules.darwin; [
      kutsan
    ];

    systemConstants.username = "kutsan";
  };
}
