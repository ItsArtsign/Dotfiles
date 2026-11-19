#!/usr/bin/env bash
# Installs and starts everything these dotfiles need (Arch / CachyOS).
# Safe to re-run: pacman --needed skips what's already installed.
set -euo pipefail

command -v pacman >/dev/null || { echo "This script is for Arch-based distros (pacman)."; exit 1; }
[[ $EUID -ne 0 ]] || { echo "Run as your normal user, not root (sudo is used where needed)."; exit 1; }

PACKAGES=(
  # Desktop
  hyprland uwsm noctalia waybar rofi hyprpicker xdg-desktop-portal-hyprland xdg-desktop-portal-gtk
  sddm xorg-xhost
  # Apps the keybinds launch
  kitty dolphin gnome-text-editor gnome-calculator pavucontrol playerctl
  # Shell
  fish starship
  # Audio
  pipewire pipewire-pulse pipewire-alsa wireplumber
  # Look
  ttf-jetbrains-mono-nerd adw-gtk-theme qt6ct
  # Neovim + what its plugins/LSPs need
  neovim git ripgrep fd lazygit tree-sitter-cli unzip npm curl
)
AUR_PACKAGES=(librewolf-bin)

CURSOR_URL="https://github.com/ful1e5/apple_cursor/releases/download/v2.0.1/macOS.tar.xz"
CURSOR_SHA256="9c6e5e13b068ce51a9e90a9abd6ce232ec7d25d4ceb05aa8ac76efbb99c76762"

step() { printf '\n\033[1;35m==> %s\033[0m\n' "$*"; }

step "Installing packages"
sudo pacman -S --needed "${PACKAGES[@]}"

step "Installing AUR packages (${AUR_PACKAGES[*]})"
AUR=""
for h in paru yay; do command -v "$h" >/dev/null && { AUR="$h"; break; }; done
if [[ -z "$AUR" ]]; then
  echo "No AUR helper found, building yay-bin..."
  sudo pacman -S --needed base-devel git
  tmp="$(mktemp -d)"; git clone https://aur.archlinux.org/yay-bin.git "$tmp/yay-bin"
  (cd "$tmp/yay-bin" && makepkg -si); rm -rf "$tmp"; AUR=yay
fi
"$AUR" -S --needed "${AUR_PACKAGES[@]}"

step "Installing macOS cursor (XCursor files for GTK/XWayland apps)"
ICONS="$HOME/.local/share/icons"
if [[ ! -d "$ICONS/macOS/cursors" ]]; then
  tmp="$(mktemp -d)"
  curl -fsSLo "$tmp/macOS.tar.xz" "$CURSOR_URL"
  echo "$CURSOR_SHA256  $tmp/macOS.tar.xz" | sha256sum -c --quiet
  mkdir -p "$ICONS"; tar -xJf "$tmp/macOS.tar.xz" -C "$ICONS"; rm -rf "$tmp"
else
  echo "already installed"
fi
# One theme name for both hyprcursor and XCursor
mkdir -p "$ICONS/macOS-hypr"
[[ -e "$ICONS/macOS-hypr/cursors" ]] || ln -s ../macOS/cursors "$ICONS/macOS-hypr/cursors"
if command -v gsettings >/dev/null; then
  gsettings set org.gnome.desktop.interface cursor-theme macOS-hypr
  gsettings set org.gnome.desktop.interface cursor-size 24
  gsettings set org.gnome.desktop.interface color-scheme prefer-dark
fi

step "Starting services"
systemctl --user enable --now pipewire.socket pipewire-pulse.socket wireplumber.service
if ! systemctl is-enabled display-manager.service >/dev/null 2>&1; then
  echo "No login screen enabled, enabling SDDM (takes effect after reboot)"
  sudo systemctl enable sddm.service
else
  echo "Login screen already set up ($(basename "$(readlink -f /etc/systemd/system/display-manager.service)"))"
fi

step "Installing Neovim plugins"
nvim --headless "+Lazy! sync" +qa 2>/dev/null && echo "done" || echo "skipped (run :Lazy sync inside nvim)"

if [[ "$(getent passwd "$USER" | cut -d: -f7)" != *fish ]]; then
  read -rp $'\nMake fish your default shell? [y/N] ' ok < /dev/tty
  if [[ "$ok" == [yY] ]]; then chsh -s "$(command -v fish)"; fi
fi

# If we're already inside Hyprland, apply everything now
if [[ -n "${HYPRLAND_INSTANCE_SIGNATURE:-}" ]]; then
  step "Reloading the running desktop"
  hyprctl reload >/dev/null && echo "Hyprland reloaded"
  pgrep -x noctalia >/dev/null || { setsid -f noctalia >/dev/null 2>&1; echo "started noctalia"; }
  pgrep -x waybar   >/dev/null || { setsid -f uwsm app -- waybar >/dev/null 2>&1; echo "started waybar"; }
else
  echo -e "\nAll set. Reboot (or log out) and pick \"Hyprland (uwsm-managed)\" at the login screen."
fi
