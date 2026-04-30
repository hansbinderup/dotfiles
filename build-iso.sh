#!/usr/bin/env bash
set -euo pipefail

REPO_ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

echo "==> Building NixOS installer ISO..."
nix build "$REPO_ROOT#nixosConfigurations.iso.config.system.build.isoImage" \
  --out-link "$REPO_ROOT/result" \
  "$@"

ISO_PATH=$(ls "$REPO_ROOT/result/iso/"*.iso)
echo ""
echo "ISO built: $ISO_PATH"
echo ""
echo "Flash to USB with:"
echo "  sudo dd if=$ISO_PATH of=/dev/sdX bs=4M status=progress oflag=sync"
