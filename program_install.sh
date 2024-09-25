# /bin/zsh

confirm() {
    read -r -p "$1 [y/N] " ans
    case "$ans" in
        [yY])
            true
            ;;
        *)
            false
            ;;
    esac
}

# tiny-aura
confirm "Install tiny-aura?" && \
    git clone git@github.com:jtexeira/tiny-aura && \
    sudo make ./tiny-aura && \
    rm -rf ./tiny-aura

# to change paralell downloads and enable multilib
printf "This next step will open nvim to edit /etc/pacman.conf\n"
confirm "Do you wish to proceed?" && sudo nvim /etc/pacman.conf

# JS
confirm "Install nvm?" && aura nvm

confirm "Install main programs?" && sudo pacman -S tmux foot wl-clipboard cliphist wofi mako hyprpaper pavucontrol pipewire pipewire-jack pipewire-alsa pipewire-pulse pipewire-docs pipewire-roc pipewire-session-manager man rust go steam mako zoxide libsixel

# nvim
confirm "Install packer?" && git clone https://github.com/wbthomason/packer.nvim "$env:LOCALAPPDATA\nvim-data\site\pack\packer\start\packer.nvim"

# tmux
confirm "Install tpm (tmux)?" && git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm

confirm "Delete this script?" && rm ~/program_install.sh
