{ config, pkgs, ... }:

let
  beo-wireguard = pkgs.writeShellScriptBin "beo-wireguard" ''
    case "$1" in
      up)
        echo "Starting (wg0)..."
        sudo systemctl start wg-quick-wg0.service
        ;;
      down)
        echo "Stopping (wg0)..."
        sudo systemctl stop wg-quick-wg0.service
        ;;
      status)
        systemctl status wg-quick-wg0.service
        ;;
      *)
        echo "Usage: beo-wireguard {up|down|status}"
        exit 1
        ;;
    esac
  '';
in
{
  environment.systemPackages = [
    pkgs.wireguard-tools
    beo-wireguard
  ];

  # Required for routing to work correctly with split-tunnel VPNs
  networking.firewall.checkReversePath = "loose";

  networking.wg-quick.interfaces.wg0 = {
    autostart = false;
    configFile = "/etc/wireguard/wg0.conf";
  };
}
