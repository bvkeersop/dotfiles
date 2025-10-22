#!/bin/bash

link_config_file() {
    local source_path="$1"
    local target_path="$2"

    mkdir -p "$(dirname "$target_path")"

    if [ -f "$target_path" ] && [ ! -L "$target_path" ]; then
        echo "Backing up existing $(basename "$target_path") to $(basename "$target_path").backup"
        mv "$target_path" "$target_path.backup"
    fi

    ln -sf "$source_path" "$target_path"
    echo "Symlinked: $target_path → $source_path"
}