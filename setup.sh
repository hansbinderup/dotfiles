#!/usr/bin/env bash
set -euo pipefail

DOTFILES_DIR="$HOME/repos/dotfiles"
DOTFILES_REPO="https://github.com/hansbinderup/dotfiles"

echo "==> Cloning dotfiles..."
mkdir -p "$HOME/repos"
git clone "$DOTFILES_REPO" "$DOTFILES_DIR"

echo "==> Linking NixOS config..."
sudo ln -sf "$DOTFILES_DIR/nixos/configuration.nix" /etc/nixos/configuration.nix

echo "==> Linking configs..."
mkdir -p "$HOME/.config"
ln -sf "$DOTFILES_DIR"/configs/* "$HOME/.config/"

echo "Done!"
