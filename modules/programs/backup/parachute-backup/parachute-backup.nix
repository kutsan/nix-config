{
  flake.modules.darwin.parachute-backup = {
    home-manager.sharedModules = [
      {
        manualSetup.parachute-backup = [
          "Add Parachute Backup to **System Settings > General > Login Items & Extensions**."
        ];
      }
    ];
  };
}
