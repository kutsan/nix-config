{
  flake.modules.homeManager.identity =
    { lib, ... }:
    {
      options.identity = {
        fullName = lib.mkOption {
          type = lib.types.str;
          description = "Full name used for authorship, like commits.";
        };

        email = lib.mkOption {
          type = lib.types.str;
          description = "Email address used for authorship.";
        };

        website = lib.mkOption {
          type = lib.types.nullOr lib.types.str;
          default = null;
          description = "Personal website, if any.";
        };

        signingKey = lib.mkOption {
          type = lib.types.nullOr lib.types.str;
          default = null;
          description = "GPG key that signs commits and tags, if any.";
        };
      };
    };
}
