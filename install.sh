#!/bin/bash

# Determine target user and their home directory (handle sudo)
if [ -n "$SUDO_USER" ]; then
    TARGET_USER="$SUDO_USER"
else
    TARGET_USER="$(whoami)"
fi
USER_HOME=$(eval echo "~$TARGET_USER")

echo -e "\e[33mWarning: This going to overwrite all your configs, are you sure?[Y/N]\e[0m"
read -r response

if [[ "$response" =~ ^[Yy]$ ]]; then
    # Check if yay is installed
    if ! command -v yay &> /dev/null; then
        echo "yay not found. Installing yay..."
        sudo pacman -S --needed git base-devel
        git clone https://aur.archlinux.org/yay.git
        cd yay || exit
        sudo -K
        makepkg -si
        sudo -v
        cd .. || exit
        rm -rf yay
    else
        echo "yay is already installed"
    fi

    # Install packages from pacman_packages.txt
    echo "Installing packages from pacman_packages.txt..."
    yay -S --noconfirm --needed - < "${USER_HOME}/Mahoraga-Dotfiles/pacman_packages.txt"

    # Change login shell for the target user to zsh (assumes zsh is present)
    ZSH_PATH="/usr/bin/zsh"
    if [ "$TARGET_USER" != "root" ]; then
        if [ "$(id -u)" -eq 0 ]; then
            sudo chsh -s "$ZSH_PATH" "$TARGET_USER" && echo "Shell changed for $TARGET_USER to $ZSH_PATH"
        else
            chsh -s "$ZSH_PATH" "$TARGET_USER" && echo "Shell changed for $TARGET_USER to $ZSH_PATH"
        fi
        # Check and install Oh My Zsh if not present
        if [ ! -d "${USER_HOME}/.oh-my-zsh" ]; then
            echo "Installing Oh My Zsh..."
            if [ "$(id -u)" -eq 0 ]; then
                sudo -u "$TARGET_USER" sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended
            else
                sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended
            fi
        else
            echo "Oh My Zsh is already installed"
        fi

        
    else
        echo "Skipping shell change for root user"
    fi

    echo "Installing Zsh plugins..."
    git clone https://github.com/zsh-users/zsh-syntax-highlighting.git "${USER_HOME}/.oh-my-zsh/custom/plugins/zsh-syntax-highlighting"
    git clone https://github.com/zsh-users/zsh-autosuggestions "${USER_HOME}/.oh-my-zsh/custom/plugins/zsh-autosuggestions"
    git clone --depth=1 https://github.com/romkatv/powerlevel10k.git "${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k"
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
