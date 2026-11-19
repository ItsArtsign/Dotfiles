# Dotfiles

My CachyOS + Hyprland setup: sharp, square, **Catppuccin Mocha** everywhere.

## Install

```sh
git clone https://github.com/ItsArtsign/Dotfiles ~/.dotfiles && ~/.dotfiles/install.sh && ~/.dotfiles/deps.sh
```

1. **`install.sh`** asks first, backs up any file it would overwrite to
   `~/.dotfiles-backup/<date>/`, then copies everything in `home/` into `$HOME`.
2. **`deps.sh`** (Arch / CachyOS) installs and starts everything the configs use:
   - all packages via pacman (`--needed`, so nothing gets reinstalled), plus `librewolf-bin` from the AUR
     (builds `yay` first if you have no AUR helper)
   - the macOS cursor (downloaded and checksum-verified) and GTK cursor/dark-mode settings
   - PipeWire audio services, and SDDM as the login screen if you don't already have one
   - Neovim plugins, and optionally fish as your default shell
   - if you're already in Hyprland: reloads it and starts Noctalia + Waybar

Both scripts are safe to re-run.

## What's included

| Path | What |
|---|---|
| `.config/hypr/` | Hyprland (Lua config): binds, rules, animations, 10px gaps, no rounding |
| `.config/uwsm/env` | Session env vars (cursor, Qt/Wayland, NVIDIA) |
| `.config/waybar/` | Top bar, 38px, square |
| `.config/rofi/` | Launcher |
| `.config/kitty/` | Terminal + Catppuccin Mocha theme |
| `.config/fish/config.fish`, `.config/starship.toml` | Shell + prompt |
| `.config/nvim/` | Neovim (lazy.nvim, LSP, IntelliJ-style keys) |
| `.config/noctalia/`, `.local/state/noctalia/` | Noctalia shell settings |
| `.config/librewolf/` | LibreWolf overrides (Figma/Photopea work) |
| `.config/gtk-*`, `xsettingsd`, `kcminputrc`, `.icons/` | GTK theme, cursor (`macOS-hypr`, 24) |
| `.config/mimeapps.list` | Default apps (LibreWolf as browser) |

## Notes

Wallpapers aren't included. Set your own in Noctalia (Super + Shift + W).
The NVIDIA lines in `.config/uwsm/env` are for NVIDIA GPUs. Remove them on AMD/Intel.
