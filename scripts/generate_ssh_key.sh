#!/usr/bin/env bash
# ssh_keygen.sh
# Usage: ./ssh_keygen.sh <keyname>

generate_ssh_key() {
    local key_name="$1"
    if [ -z "$key_name" ]; then
        echo "Usage: $0 <keyname>"
        exit 1
    fi

    local key_path="$HOME/.ssh/$key_name"

    # Check if key already exists
    if [ -f "$key_path" ] || [ -f "$key_path.pub" ]; then
        echo "Key $key_path already exists. Skipping generation."
        exit 0
    fi

    # Prompt user for passphrase
    echo "Enter passphrase for new SSH key (leave empty for no passphrase):"
    read -s passphrase
    echo

    # Generate the key
    ssh-keygen -t ed25519 -f "$key_path" -N "$passphrase"

    echo "SSH key generated:"
    echo "Private key: $key_path"
    echo "Public key:  $key_path.pub"

    # Optionally add the key to ssh-agent
    echo "Adding key to ssh-agent..."
    eval "$(ssh-agent -s)"
    ssh-add "$key_path"

    echo "Done! Remember to add $key_path.pub to your GitHub account."
}
