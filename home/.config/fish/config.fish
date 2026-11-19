source /usr/share/cachyos-fish-config/cachyos-config.fish

# overwrite greeting
# potentially disabling fastfetch
#function fish_greeting
#    # smth smth
#end

# terminal-wakatime setup
set -gx PATH "$HOME/.wakatime" $PATH
terminal-wakatime init fish | source

# bun
set --export BUN_INSTALL "$HOME/.bun"
set --export PATH $BUN_INSTALL/bin $PATH

# --- Rice: Catppuccin Mocha + starship (managed via ~/.agents, see LOG.md) ---
if status is-interactive
    # Syntax colors. Force the dark (Mocha) variant; fish would otherwise pick Latte on a light-detected terminal.
    fish_config theme choose catppuccin-mocha --color-theme=dark

    # Prompt — only if starship is installed; otherwise CachyOS's default prompt stays
    if type -q starship
        starship init fish | source
    end
end
