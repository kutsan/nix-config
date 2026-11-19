{ inputs, ... }:
{
  flake.modules.darwin.work-macbook = {
    imports = with inputs.self.modules.darwin; [
      kutsan
    ];

    systemConstants.username = "kutsan";
  };
}
