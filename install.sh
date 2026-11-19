#!/usr/bin/env bash
# Copies these dotfiles into $HOME. Existing files are backed up first.
set -euo pipefail
REPO="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
SRC="$REPO/home"
BK="$HOME/.dotfiles-backup/$(date +%Y-%m-%d_%H%M%S)"

echo "Installing dotfiles from $SRC"
echo "Existing files will be backed up to $BK"
read -rp "Continue? [y/N] " ok < /dev/tty
[[ "$ok" == [yY] ]] || { echo "Aborted."; exit 0; }

cd "$SRC"
find . -type f -print0 | while IFS= read -r -d '' f; do
  rel="${f#./}"; dest="$HOME/$rel"
  if [[ -e "$dest" ]]; then mkdir -p "$BK/$(dirname "$rel")"; cp -a "$dest" "$BK/$rel"; fi
  mkdir -p "$(dirname "$dest")"
  cp "$f" "$dest"
  # Put this machine's home path back in place of the __HOME__ placeholder
  if grep -qI '__HOME__' "$dest" 2>/dev/null; then sed -i "s#__HOME__#$HOME#g" "$dest"; fi
done

echo "Done. Backups (if any) are in $BK"
echo "Log out and back in (or: hyprctl reload) to apply everything."
