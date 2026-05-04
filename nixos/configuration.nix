{ config, lib, pkgs, ... }:

{
  imports =
    [
      ./hardware/work-laptop.nix
      ./services/kernel.nix
      ./services/git.nix
      ./services/network.nix
      ./services/bash.nix
      ./services/neovim.nix
      ./services/aliasx.nix
      ./services/tmux.nix
      ./services/github-copilot.nix
      ./services/openconnect.nix
      ./services/audio.nix
      ./services/jlink.nix
    ];

  nixpkgs.config.allowUnfree = true;

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  # Set your time zone.
  time.timeZone = "Europe/Copenhagen";

  fonts.packages = with pkgs; [
    nerd-fonts.fira-code
  ];

  # Configure keymap in X11
  services.xserver.xkb.layout = "dk";
  services.dbus.enable = true;

  hardware.enableRedistributableFirmware = true;
  hardware.bluetooth.enable = true;
  hardware.bluetooth.powerOnBoot = true;

  # increase ulimit
  security.pam.loginLimits = [{
    domain = "*";
    type = "soft";
    item = "nofile";
    value = "65536";
  }];

  services.libinput.enable = true;
  services.avahi.enable = true;
  services.avahi.nssmdns4 = true;
  services.avahi.openFirewall = true;

  # docker setup
  virtualisation.docker.enable = true;
  virtualisation.docker.rootless.enable = true;
  virtualisation.docker.storageDriver = "btrfs";

  users.users.habi = {
    isNormalUser = true;
    extraGroups = [ "wheel" "docker" "uucp" "dialout" "video" "netdev" "plugdev" ];
    packages = with pkgs; [
      tree
    ];
  };

  programs.firefox.enable = true;
  programs.hyprland.enable = true;

  environment.systemPackages = with pkgs; [
    wget
    kitty
    wofi
    dunst
    hyprpaper
    waybar
    lazygit
    bitwarden-cli
    cmake
    libgcc
    gcc-arm-embedded
    fastfetch
    wl-clipboard
    grim
    slurp
    swaylock
    swayidle
    bluez
    libnotify
    jq
    python3
    tio
    adwaita-icon-theme
    unzip
    zk
 ];

  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  system.stateVersion = "25.11";

}

