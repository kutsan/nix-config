{ inputs, ... }:
{
  flake.modules.darwin.personal = {
    imports = with inputs.self.modules.darwin; [
      kutsan
    ];
  };
}
