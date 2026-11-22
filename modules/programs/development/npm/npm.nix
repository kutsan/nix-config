{
  flake.modules.homeManager.npm =
    { config, lib, ... }:
    {
      home.sessionVariables = {
        NPM_CONFIG_INIT_AUTHOR_NAME = config.identity.fullName;
        NPM_CONFIG_INIT_AUTHOR_EMAIL = config.identity.email;
        NPM_CONFIG_INIT_AUTHOR_URL = config.identity.website;
        NPM_CONFIG_INIT_LICENSE = "MIT";
        NPM_CONFIG_INIT_VERSION = "0.0.0";
        NPM_CONFIG_SIGN_GIT_TAG = lib.boolToString (config.identity.signingKey != null);
      };
    };
}
