{
  config,
  lib,
  pkgs,
  ...
}:

let
  cfg = config.bogo.intune;

  intune-portal-wrapped = pkgs.writeShellScriptBin "intune-portal" ''
    set -e

    echo "==> Spoofing Ubuntu 24.04 in /etc/os-release..."
    FAKE_OS_RELEASE=$(mktemp)

    cat << 'EOF' > "$FAKE_OS_RELEASE"
    NAME="Ubuntu"
    VERSION="24.04 LTS (Noble Numbat)"
    ID=ubuntu
    ID_LIKE=debian
    PRETTY_NAME="Ubuntu 24.04 LTS"
    VERSION_ID="24.04"
    HOME_URL="https://www.ubuntu.com/"
    SUPPORT_URL="https://help.ubuntu.com/"
    BUG_REPORT_URL="https://bugs.launchpad.net/ubuntu/"
    PRIVACY_POLICY_URL="https://www.ubuntu.com/legal/terms-and-policies/privacy-policy"
    VERSION_CODENAME=noble
    UBUNTU_CODENAME=noble
    EOF

    trap 'echo "==> Restoring original /etc/os-release..."; sudo umount /etc/os-release; rm -f "$FAKE_OS_RELEASE"' EXIT

    sudo mount --bind "$FAKE_OS_RELEASE" /etc/os-release

    export GIO_EXTRA_MODULES="${pkgs.glib-networking}/lib/gio/modules"
    export SSL_CERT_FILE="/etc/ssl/certs/ca-certificates.crt"
    export SSL_CERT_DIR="/etc/ssl/certs"
    export WEBKIT_DISABLE_SANDBOX_THIS_IS_DANGEROUS="1"
    export WEBKIT_DISABLE_DMABUF_RENDERER="1"
    export GDK_BACKEND=x11
    export WEBKIT_DISABLE_COMPOSITING_MODE="1"
    export LIBGL_ALWAYS_SOFTWARE="1"
    export MSAL_ALLOW_PII="true"
    export MSAL_LOG_LEVEL="4"

    ${pkgs.dbus}/bin/dbus-update-activation-environment --systemd --all

    echo "==> Starting Intune Portal..."
    ${pkgs.intune-portal}/bin/intune-portal
  '';
in
{
  options.bogo.intune = {
    enable = lib.mkEnableOption "Microsoft Intune and Identity Broker setup";
  };

  config = lib.mkIf cfg.enable {
    services.intune.enable = true;
    programs.dconf.enable = true;
    services.gnome.gnome-keyring.enable = true;

    systemd.services.microsoft-identity-device-broker.environment = {
      GIO_EXTRA_MODULES = "${pkgs.glib-networking}/lib/gio/modules";
      SSL_CERT_FILE = "/etc/ssl/certs/ca-certificates.crt";
      SSL_CERT_DIR = "/etc/ssl/certs";
      WEBKIT_DISABLE_SANDBOX_THIS_IS_DANGEROUS = "1";
      MSAL_ALLOW_PII = "true";
      MSAL_LOG_LEVEL = "4";
      GDK_BACKEND = "x11";
      WEBKIT_DISABLE_COMPOSITING_MODE = "1";
      LIBGL_ALWAYS_SOFTWARE = "1";
    };

    environment.systemPackages = [
      intune-portal-wrapped
      pkgs.glib-networking
      pkgs.seahorse
      pkgs.microsoft-edge
    ];

    nixpkgs.config.allowUnfreePredicate = pkg:
      builtins.elem (lib.getName pkg) [
        "intune-portal"
        "microsoft-identity-broker"
        "microsoft-edge"
        "microsoft-edge-stable"
      ];
  };
}
