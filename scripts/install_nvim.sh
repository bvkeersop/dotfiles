install_nvim() {
    # Directories
    INSTALL_DIR="$HOME/neovim"       # Where Neovim will be installed
    NVIM_SRC="$HOME/neovim-src"      # Where Neovim source will be cloned

    echo ">>> Installing Neovim build prerequisites..."
    sudo apt-get update
    sudo apt-get install -y ninja-build gettext curl build-essential git jq

    # --- Check if Neovim is already installed ---
    if [ -x "$INSTALL_DIR/bin/nvim" ]; then
        echo ">>> Neovim already installed at $INSTALL_DIR. Skipping build."
        return
    fi

    # --- Clone or update Neovim source outside dotfiles ---
    echo ">>> Cloning/updating Neovim source in $NVIM_SRC ..."
    if [ ! -d "$NVIM_SRC" ]; then
        git clone https://github.com/neovim/neovim.git "$NVIM_SRC"
    else
        echo ">>> Neovim source exists; pulling latest..."
        git -C "$NVIM_SRC" pull --ff-only
    fi

    # --- Build Neovim ---
    cd "$NVIM_SRC" || { echo "Failed to enter $NVIM_SRC"; exit 1; }

    echo ">>> Clearing previous build cache..."
    rm -rf build/

    echo ">>> Building Neovim with user-local prefix: $INSTALL_DIR"
    make CMAKE_EXTRA_FLAGS="-DCMAKE_INSTALL_PREFIX=$INSTALL_DIR"
    make install

    # --- Ensure INSTALL_DIR/bin is in PATH ---
    SHELL_RC="$HOME/.zshrc"
    if ! grep -q "$INSTALL_DIR/bin" "$SHELL_RC"; then
        echo "export PATH=\"$INSTALL_DIR/bin:\$PATH\"" >> "$SHELL_RC"
        echo ">>> Added Neovim to PATH in $SHELL_RC"
        echo ">>> Reload your shell or run: source $SHELL_RC"
    fi

    # --- Verification ---
    if command -v nvim &>/dev/null; then
        echo ">>> Neovim installed successfully!"
        nvim --version | head -n1
    else
        echo ">>> Neovim installed, but 'nvim' not in PATH yet."
        echo "Make sure to reload your shell or run:"
        echo "export PATH=\"$INSTALL_DIR/bin:\$PATH\""
    fi
}
