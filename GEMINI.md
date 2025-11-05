# Gemini Context: Dotfiles

This directory contains personal dotfiles for a customized Arch Linux + Hyprland setup. It is managed using `gnu stow`.

## Directory Overview

This is a non-code project, consisting of configuration files for various applications. The main applications used are:

*   **Window Manager:** Hyprland
*   **Bar:** Waybar
*   **Terminal:** Kitty
*   **Shell:** fish
*   **Browser:** Qutebrowser
*   **Notifications:** Mako
*   **File Manager:** Yazi
*   **Wallpaper:** Swww
*   **Editor:** Nvim

## Key Files

*   `.stowrc`: Configures `stow` to use the `--dotfiles` flag, which means it will look for files in `dot-` prefixed directories.
*   `README.md`: The main documentation for this repository, including keybindings and screenshots.
*   `hypr/dot-config/hypr/hyprland.conf`: The main configuration file for the Hyprland window manager. It sources other configuration files.
*   `fish/dot-config/fish/config.fish`: The configuration file for the fish shell. It sets up aliases, environment variables, and the starship prompt.
*   `scripts/bin/theme.sh`: A script that uses `pywal` to generate and apply a color theme from an image.
*   `waybar/dot-config/waybar/`: The configuration directory for the Waybar status bar.
*   `qutebrowser/dot-config/qutebrowser/config.py`: The configuration file for the Qutebrowser web browser.
*   `kitty/dot-config/kitty/kitty.conf`: The configuration file for the Kitty terminal emulator.
*   `yazi/dot-config/yazi/yazi.toml`: The configuration file for the Yazi file manager.
*   `nvim/dot-config/nvim/init.lua`: The main configuration file for Neovim.
*   `starship/dot-config/starship.toml`: The configuration file for the Starship cross-shell prompt.

## Usage

The dotfiles are managed using `gnu stow`. To install the dotfiles, you would run `stow` on the desired package. For example, to install the `kitty` configuration, you would run `stow kitty`.

The `.stowrc` file is configured to use the `--dotfiles` flag, which means that `stow` will look for files in `dot-` prefixed directories. For example, the `kitty` package contains a `dot-config/kitty` directory, which will be symlinked to `~/.config/kitty`.

## Theming

Theming is handled by `pywal` and a set of custom scripts. The `scripts/bin/theme.sh` script is the main entry point for changing the theme. It takes an image as input, and then uses `pywal` to generate a color scheme. The color scheme is then applied to various applications using templates located in `wal/dot-config/wal/templates`.
