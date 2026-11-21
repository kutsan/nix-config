{
  flake.modules.darwin.networking = {
    networking.applicationFirewall = {
      enable = true;
      enableStealthMode = true;
    };
  };
}
