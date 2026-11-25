{
  flake.modules.darwin.networking = {
    networking.applicationFirewall = {
      enable = true;
      enableStealthMode = true;
      blockAllIncoming = false;
      allowSigned = true;
      allowSignedApp = true;
    };
  };
}
