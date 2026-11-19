# kutsan's nix-config

## Installation

> [!IMPORTANT]
> This repository isn't meant to be installed by others. The documentation here describes how I set it up on my own machines. Feel free to browse through the files and take whatever parts you find useful.

1. Set the configuration folder for your system:

   ```sh
   CONFIGURATION_PATH="/etc/nixos" # or "/etc/nix-darwin" for macOS
   ```

1. Create the configuration folder, owned by your user:

   ```sh
   sudo install -d -o "$(id -un)" "$CONFIGURATION_PATH"
   ```

1. Clone the repository into it:

   ```sh
   nix-shell -p git --run "git clone https://github.com/kutsan/dotfiles.git $CONFIGURATION_PATH"

   # or
   git clone https://github.com/kutsan/dotfiles.git "$CONFIGURATION_PATH"
   ```

1. Run the installation script:

   ```sh
   "$CONFIGURATION_PATH/install.sh"
   ```

## License

GPL-3.0
