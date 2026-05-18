{ config, pkgs, ... }:

{
  virtualisation.docker.enable = true;
  virtualisation.docker.rootless.enable = true;
  virtualisation.docker.storageDriver = "btrfs";

  # expose our tzdata zoneinfo as some of our containers expect those to be in place
  # TODO: separate time zone handling and docker
  systemd.tmpfiles.rules = [
    "L+ /usr/share/zoneinfo - - - - ${pkgs.tzdata}/share/zoneinfo"
  ];

  environment.systemPackages = with pkgs; [
    tzdata
  ];
}
