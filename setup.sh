#!/usr/bin/env bash
set -euo pipefail

DOTFILES_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

echo "==> Linking NixOS config..."
sudo ln -sf "$DOTFILES_DIR/nixos/configuration.nix" /etc/nixos/configuration.nix

echo "==> Linking configs..."
mkdir -p "$HOME/.config"
ln -sf "$DOTFILES_DIR"/configs/* "$HOME/.config/"

echo "Done!"
