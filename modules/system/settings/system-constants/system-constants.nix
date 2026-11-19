{
  flake.modules.generic.system-constants =
    { lib, ... }:
    {
      options.systemConstants = {
        username = lib.mkOption {
          type = lib.types.str;
          description = "The user who owns the machine.";
        };
      };
    };
}
