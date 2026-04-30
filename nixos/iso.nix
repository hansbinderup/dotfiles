{ pkgs, self, ... }:

let
  installScript = pkgs.writeShellScriptBin "install-nixos" ''
    set -euo pipefail

    echo "╔══════════════════════════════╗"
    echo "║      NixOS Installer         ║"
    echo "╚══════════════════════════════╝"
    echo ""

    echo "Select configuration:"
    echo "  1) nixos-work  (user: habi)"
    echo "  2) nixos-private  (user: hans)"
    read -rp "Choice [1]: " CFG_CHOICE
    case "''${CFG_CHOICE:-1}" in
      1) CONFIG="nixos-work";  USERNAME="habi" ;;
      2) CONFIG="nixos-private"; USERNAME="hans" ;;
      *) echo "Invalid choice"; exit 1 ;;
    esac

    echo ""
    echo "Available disks:"
    lsblk -d -o NAME,SIZE,MODEL
    echo ""

    read -rp "Enter target disk (e.g. /dev/nvme0n1): " DISK

    if [[ ! -b "$DISK" ]]; then
      echo "Error: '$DISK' is not a block device."
      exit 1
    fi

    echo ""
    echo "WARNING: This will permanently ERASE all data on $DISK"
    read -rp "Type 'yes' to confirm: " CONFIRM
    if [[ "$CONFIRM" != "yes" ]]; then
      echo "Aborted."
      exit 1
    fi

    echo ""
    echo "==> Partitioning, formatting, and installing NixOS on $DISK ($CONFIG)..."
    echo "    (You will be prompted to set a root password at the end)"
    echo ""

    # disko-install handles partitioning + formatting + nixos-install in one step
    sudo disko-install \
      --flake /etc/dotfiles#"$CONFIG" \
      --disk main "$DISK"

    echo ""
    echo "Installation complete!"
    echo "   Set your user password after first login with: passwd $USERNAME"
  '';
in
{
  environment.systemPackages = with pkgs; [
    installScript
    disko
    git
    gptfdisk
    dosfstools
    btrfs-progs
    cryptsetup
    parted
  ];

  # Use iwd instead of NetworkManager for wireless
  networking.networkmanager.enable = false;
  networking.wireless.iwd.enable = true;

  # Embed the dotfiles repo into the ISO at /etc/dotfiles
  environment.etc."dotfiles".source = self;

  isoImage.isoBaseName = "nixos-installer";
  isoImage.appendToMenuLabel = " NixOS Installer";

  # Autologin on the ISO for convenience
  services.getty.autologinUser = "nixos";
}
