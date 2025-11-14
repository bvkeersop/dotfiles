install_cmake() {
    set -euo pipefail

    echo ">>> Checking for existing CMake installation..."
    if command -v cmake &>/dev/null; then
        CURRENT_VERSION=$(cmake --version | head -n1 | awk '{print $3}')
        echo ">>> Current CMake version: $CURRENT_VERSION"
    else
        CURRENT_VERSION="0.0.0"
        echo ">>> No CMake installation found."
    fi

    echo ">>> Fetching latest CMake version..."
    LATEST_VERSION=$(curl -Ls -o /dev/null -w '%{url_effective}' \
        https://github.com/Kitware/CMake/releases/latest | sed 's#.*/##')
    VERSION_NUM="${LATEST_VERSION#v}"  # strip leading "v"
    echo ">>> Latest version: $LATEST_VERSION (numeric: $VERSION_NUM)"

    # Compare versions
    if dpkg --compare-versions "$CURRENT_VERSION" ge "$VERSION_NUM"; then
        echo ">>> CMake is already up to date. Skipping installation."
        return
    fi

    echo ">>> New version detected, installing CMake $VERSION_NUM ..."

    sudo apt-get update
    sudo apt-get install -y curl

    INSTALLER="cmake-${VERSION_NUM}-linux-x86_64.sh"
    URL="https://github.com/Kitware/CMake/releases/download/${LATEST_VERSION}/${INSTALLER}"

    # --- Use a temporary directory to avoid polluting current dir ---
    TMPDIR=$(mktemp -d)
    echo ">>> Downloading CMake installer to temporary directory: $TMPDIR"
    curl -fL "$URL" -o "$TMPDIR/$INSTALLER"
    chmod +x "$TMPDIR/$INSTALLER"

    echo ">>> Installing to /opt/cmake..."
    sudo mkdir -p /opt/cmake
    sudo "$TMPDIR/$INSTALLER" --skip-license --prefix=/opt/cmake

    # --- Add to PATH if missing ---
    if ! grep -q "/opt/cmake/bin" "$HOME/.bashrc"; then
        echo 'export PATH="/opt/cmake/bin:$PATH"' >> "$HOME/.bashrc"
        echo ">>> Added /opt/cmake/bin to PATH in ~/.bashrc"
    fi

    echo ">>> Installation complete:"
    /opt/cmake/bin/cmake --version

    # Clean up
    rm -rf "$TMPDIR"
}
