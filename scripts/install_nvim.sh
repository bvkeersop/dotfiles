install_nvim() {
    INSTALL_DIR="$HOME/neovim"
    NVIM_SRC="$HOME/neovim-src"

    echo ">>> Installing Neovim build prerequisites..."
    sudo apt-get update
    sudo apt-get install -y ninja-build gettext curl build-essential git jq

    # --- Check if Neovim is already installed ---
    if [ -x "$INSTALL_DIR/bin/nvim" ]; then
        echo ">>> Neovim already installed at $INSTALL_DIR. Skipping build."
        return
    fi

    # --- Clone or update Neovim source ---
    echo ">>> Cloning/updating Neovim source..."
    if [ ! -d "$NVIM_SRC" ]; then
        git clone https://github.com/neovim/neovim.git "$NVIM_SRC"
    else
        echo ">>> Neovim source exists; pulling latest..."
        git -C "$NVIM_SRC" pull --ff-only
    fi

    cd "$NVIM_SRC"

    echo ">>> Clearing previous build cache..."
    rm -rf build/

    echo ">>> Building Neovim with user-local prefix: $INSTALL_DIR"
    make CMAKE_EXTRA_FLAGS="-DCMAKE_INSTALL_PREFIX=$INSTALL_DIR"
    make install

    # --- Verification ---
    if command -v nvim &>/dev/null; then
        echo ">>> Neovim installed successfully!"
        nvim --version | head -n1
    else
        echo ">>> Neovim installed, but 'nvim' not in PATH yet."
        echo "Make sure $INSTALL_DIR/bin is in your PATH (it should be in .zshrc)."
    fi
}
