# Edit this configuration file to define what should be installed on
# your system. Help is available in the configuration.nix(5) man page, on
# https://search.nixos.org/options and in the NixOS manual (`nixos-help`).

{ config, lib, pkgs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware/work-pc.nix
      ./services/git.nix
      ./services/kernel.nix
      ./services/network.nix
      ./services/bash.nix
      ./services/neovim.nix
      ./services/aliasx.nix
      ./services/tmux.nix
      ./services/github-copilot.nix
      ./services/openconnect.nix
      ./services/audio.nix
    ];

  nixpkgs.config.allowUnfree = true;

  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  # Use the systemd-boot EFI boot loader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  # Set your time zone.
  time.timeZone = "Europe/Copenhagen";

  # NixOS gets timezones from its store, but some programs/scripts assume a vanilla timezone folder,
  system.activationScripts.zoneinfo = {
    text = ''
      rm -rf /usr/share/zoneinfo
      ln -sf ${pkgs.tzdata}/share/zoneinfo /usr/share/zoneinfo
    '';
  };

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
  services.xserver.xkb.layout = "gb";
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


  # Enable touchpad support (enabled default in most desktopManager).
  services.libinput.enable = true;
  services.avahi.enable = true;

  # docker setup
  virtualisation.docker.enable = true;
  virtualisation.docker.rootless.enable = true;
  # virtualisation.docker.storageDriver = "btrfs";

  users.users.clara = {
    isNormalUser = true;
    home = "/home/clara";
    extraGroups = [ "wheel" "docker" "uucp" "dialout" "video" "netdev" ];
    packages = with pkgs; [
       tree
     ];
   };

  programs.firefox.enable = true;
  programs.hyprland.enable = true;
  programs.steam.enable = true;

  environment.systemPackages = with pkgs; [
    wget
    kitty
    git
    wofi
    dunst
    hyprpaper
    waybar
    lazygit
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
    gh
    tio
    adwaita-icon-theme
    hyprsunset
    openssl
    cspell
    brightnessctl
    pamixer
    libreoffice
    discord
    uv
    signal-desktop
    gdb
    unzip
    tmate
    sl
 ];

  # Do NOT change this value unless you have manually inspected all the changes it would make to your configuration,
  # and migrated your data accordingly.
  #
  # For more information, see `man configuration.nix` or https://nixos.org/manual/nixos/stable/options#opt-system.stateVersion .
  system.stateVersion = "25.11"; # Did you read the comment?

}


