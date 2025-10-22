#!/bin/bash

set -e  # Exit on any error

source "$HOME/dotfiles/scripts/link_config_file.sh"

echo "==> Updating system packages..."
sudo apt update && sudo apt upgrade -y

echo "==> Installing required packages..."
sudo apt install -y \
    zsh \
    curl \
    git \
    software-properties-common

echo "==> Installing Neovim..."
sudo add-apt-repository ppa:neovim-ppa/stable -y
sudo apt update -y
sudo apt install neovim -y

echo "==> Installing Starship prompt..."
curl -sS https://starship.rs/install.sh | sh -s -- -y

echo "==> Cloning dotfiles repository..."
if [ ! -d "$HOME/dotfiles" ]; then
    git clone https://github.com/bvkeersop/dotfiles.git "$HOME/dotfiles"
else
    echo "Dotfiles repo already exists at ~/dotfiles. Skipping clone."
fi

echo "==> Setting up Starship config..."
link_config_file "$HOME/dotfiles/starship/starship.toml" "$HOME/.config/starship.toml"

echo "==> Setting up ZSH config..."
link_config_file "$HOME/dotfiles/zsh/.zshrc" "$HOME/.zshrc"

echo "==> Setting Zsh as your default shell..."
chsh -s "$(which zsh)"

echo ""
echo "Dev environment setup complete!"
echo "Restart your terminal or run: exec zsh"
