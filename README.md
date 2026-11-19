# Dotfiles

My CachyOS + Hyprland setup: sharp, square, **Catppuccin Mocha** everywhere.

## Install

```sh
git clone https://github.com/ItsArtsign/Dotfiles ~/.dotfiles && ~/.dotfiles/install.sh
```

The script asks before doing anything, backs up any file it would overwrite to
`~/.dotfiles-backup/<date>/`, then copies everything in `home/` into `$HOME`.
It does **not** install packages.

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

## Packages you'll want

`hyprland uwsm waybar rofi kitty fish starship neovim librewolf noctalia-shell xsettingsd`
plus the `macOS-hypr` cursor theme and a Catppuccin Mocha GTK theme.
Wallpapers aren't included. Set your own in Noctalia.

The NVIDIA lines in `.config/uwsm/env` are for NVIDIA GPUs. Remove them on AMD/Intel.
