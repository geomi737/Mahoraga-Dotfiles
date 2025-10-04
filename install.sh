#!/bin/bash

# Get user's home directory
USER_HOME=$HOME

echo -e "\e[33mWarning: This going to overwrite all your configs, are you sure?[Y/N]\e[0m"
read -r response

if [[ "$response" =~ ^[Yy]$ ]]; then
    # Check if yay is installed
    if ! command -v yay &> /dev/null; then
        echo "yay not found. Installing yay..."
        sudo pacman -S --needed git base-devel
        git clone https://aur.archlinux.org/yay.git
        cd yay || exit
        makepkg -si
        cd .. || exit
        rm -rf yay
    else
        echo "yay is already installed"
    fi

    # Install packages from pacman_packages.txt
    echo "Installing packages from pacman_packages.txt..."
    yay -S --needed - < "${USER_HOME}/Mahoraga-Dotfiles/pacman_packages.txt"

    # Copy config files
    echo "Copying configuration files..."
    cp -r "${USER_HOME}/Mahoraga-Dotfiles/dotfiles/.config/"* "${USER_HOME}/.config/"
    cp "${USER_HOME}/Mahoraga-Dotfiles/dotfiles/.zshrc" "${USER_HOME}/.zshrc"
    cp -r "${USER_HOME}/Mahoraga-Dotfiles/dotfiles/Wallpapers" "${USER_HOME}/Wallpapers"

    echo -e "\e[32mConfiguration files have been installed successfully!\e[0m"
    
    # Ask for reboot
    echo -e "\e[33mReboot?[Y/N]\e[0m"
    read -r reboot_response
    
    if [[ "$reboot_response" =~ ^[Yy]$ ]]; then
        echo "Rebooting system..."
        reboot
    else
        echo "Installation completed. Please reboot your system later to apply all changes."
    fi
else
    echo "Installation cancelled."
    exit 1
fi
