{ inputs, ... }:
{
  flake.darwinConfigurations = inputs.self.lib.mkDarwin {
    system = "aarch64-darwin";
    host = "personal";
  };
}
