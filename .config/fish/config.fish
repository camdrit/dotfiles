source /usr/share/cachyos-fish-config/cachyos-config.fish

export SUDO_EDITOR=nvim
export TOOLCHAIN_ROOT=/mnt/apps/toolchain
export XCURSOR_THEME=capitaine-cursors
export ELECTRON_OZONE_PLATFORM_HINT=wayland
export SDL_VIDEODRIVER=wayland

export SSH_AUTH_SOCK="$XDG_RUNTIME_DIR/ssh-agent.socket"

oh-my-posh init fish --config ~/dracula.omp.json | source
