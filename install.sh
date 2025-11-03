#!/bin/bash

set -euo pipefail  # Exit on any error and treat unset variables as errors

source "$HOME/dotfiles/scripts/link_config_file.sh"

echo "==> Updating system packages..."
sudo apt update
sudo apt upgrade -y

echo "==> Installing required packages if missing..."

sudo apt-get install -y jq
configFile="$HOME/dotfiles/config.json"
sudo apt-get install -y $(jq -r '.packages[]' $configFile)

echo "==> Installing Neovim if missing..."
if ! command -v nvim &> /dev/null; then
    sudo add-apt-repository ppa:neovim-ppa/stable -y
    sudo apt update -y
    sudo apt install -y neovim
else
    echo "Neovim already installed. Skipping."
fi

echo "==> Installing Starship prompt if missing..."
if ! command -v starship &> /dev/null; then
    curl -sS https://starship.rs/install.sh | sh -s -- -y
else
    echo "Starship already installed. Skipping."
fi

echo "==> Cloning dotfiles repository..."
if [ ! -d "$HOME/dotfiles" ]; then
    git clone https://github.com/bvkeersop/dotfiles.git "$HOME/dotfiles"
else
    echo "Dotfiles repo already exists at ~/dotfiles. Skipping clone."
fi

echo "==> Installing zinit..."
bash -c "$(curl --fail --show-error --silent --location https://raw.githubusercontent.com/zdharma-continuum/zinit/HEAD/scripts/install.sh)"

echo "==> Setting up Starship config..."
link_config_file "$HOME/dotfiles/starship/starship.toml" "$HOME/.config/starship.toml"

echo "==> Setting up ZSH config..."
link_config_file "$HOME/dotfiles/zsh/.zshrc" "$HOME/.zshrc"

echo "==> Setting up Neovim config..."
link_config_file "$HOME/dotfiles/nvim" "$HOME/.config/nvim"

echo "==> Setting Zsh as your default shell..."
if [ "$SHELL" != "$(which zsh)" ]; then
    chsh -s "$(which zsh)"
else
    echo "Zsh is already the default shell."
fi

echo "==> Running zsh to check for errors..."
exec zsh

echo
echo "Dev environment setup complete!"