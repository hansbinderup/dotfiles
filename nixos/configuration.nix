{ config, lib, pkgs, ... }:

{
  imports =
    [
      ./hardware-configuration.nix
      ./intune.nix
    ];

  nixpkgs.config.allowUnfree = true;

  # FIXME: only required for work pc
  bogo.intune.enable = true;

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  boot.initrd.luks.devices.cryptroot.device = "/dev/disk/by-uuid/cf691ebe-a260-4d11-8fc7-85e21e13c729";
  boot.initrd.services.lvm.enable = true;

  networking.hostName = "nixos"; # Define your hostname.
  networking.networkmanager.enable = false;
  networking.wireless.iwd.enable = true;

  networking.wireless.iwd.settings = {
    Network = {
      EnableIPv6 = true;
    };
    Settings = {
      AutoConnect = true;
    };
  };

  # Set your time zone.
  time.timeZone = "Europe/Copenhagen";

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Select internationalisation properties.
#   i18n.defaultLocale = "en_US.UTF-8";
#   console = {
#     font = "fira-code";
#     keyMap = "dk";
#     useXkbConfig = true; # use xkb.options in tty.
#   };

  # Enable the X11 windowing system.
  # services.xserver.enable = true;


  fonts.packages = with pkgs; [
    nerd-fonts.fira-code
  ];

  # Configure keymap in X11
  services.xserver.xkb.layout = "dk";
  services.dbus.enable = true;

  hardware.enableRedistributableFirmware = true;
  hardware.bluetooth.enable = true;
  hardware.bluetooth.powerOnBoot = true;

  # rtkit (optional, recommended) allows Pipewire to use the realtime scheduler for increased performance.
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    pulse.enable = true;
    wireplumber.enable = true;
  };

  # increase ulimit
  security.pam.loginLimits = [{
    domain = "*";
    type = "soft";
    item = "nofile";
    value = "65536";
  }];

  services.libinput.enable = true;

  # docker setup
  virtualisation.docker.enable = true;
  virtualisation.docker.rootless.enable = true;
  virtualisation.docker.storageDriver = "btrfs";

  users.users.habi = {
    isNormalUser = true;
    extraGroups = [ "wheel" "docker" "uucp" "dialout" "video" "netdev" ];
    packages = with pkgs; [
      tree
    ];
  };

  programs.firefox.enable = true;
  programs.hyprland.enable = true;
  programs.bash.enable = true;
  programs.bash.interactiveShellInit = ''
   if [ -f "$HOME/.secrets/github_token" ]; then
     export GITHUB_TOKEN="$(cat $HOME/.secrets/github_token)"
   fi
  '';

  environment.systemPackages = with pkgs; [
    neovim
    wget
    kitty
    git
    wofi
    dunst
    hyprpaper
    tmux
    waybar
    ripgrep
    lazygit
    fzf
    gnumake
    cmake
    gcc
    fastfetch
    pavucontrol
    playerctl
    pamixer
    wl-clipboard
    grim
    slurp
    swaylock
    swayidle
    bluez
    libnotify
    jq
    python3
    gh
    tio
    github-copilot-cli
    adwaita-icon-theme
 ];

  system.stateVersion = "25.11";

}

